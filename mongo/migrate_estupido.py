# -*- coding: utf-8 -*-
import MySQLdb
from pymongo import MongoClient

#Função para converter um dicionário em unicode 
def convert2unicode(mydict):
    for k, v in mydict.iteritems():
        if isinstance(v, str):
            try:
                mydict[k] = unicode(v, errors='replace')
            except:
                pass
        elif isinstance(v, list):
            for l in v:
                convert2unicode(l)
        elif isinstance(v, dict):
            convert2unicode(v)


db = MySQLdb.connect("localhost","root","random1998","farmacia")

mongo = MongoClient('mongodb://localhost')
db_mongo = mongo['farmacia']

#####################################################################################################

def getColumns(table):
    cursor = db.cursor()
    columns = []
    cursor.execute("SELECT COLUMN_NAME FROM information_schema.columns WHERE TABLE_NAME = '%s';" % table)

    column = cursor.fetchone()
    while column is not None:
        columns.append(next(iter(column)))
        column = cursor.fetchone()
    
    return columns


def getTable(table):
    collection = []
    columns = getColumns(table)
    cursor = db.cursor()

    cursor.execute("SELECT *  FROM %s;" % table)
    
    document = {}
    data = cursor.fetchone()
    while data is not None:
        for col in columns:
            if col in ['preco', 'qt','total','desconto', 'ordenado']:
                document[col] = float(data[columns.index(col)])
            else:
                document[col] = data[columns.index(col)]
        
        if table is 'Medicamento':
            juntaFaturasMed(document)
        elif table is 'Cliente':
            juntaFaturasCliente(document)
        elif table is 'Funcionario':
            juntaFaturasFunc(document)
        elif table is 'Fatura':
            juntaClienteFatura(document)
            juntaFuncionarioFatura(document)
            juntaMedsFatura(document)
        
        convert2unicode(document)
        collection.append(document)

        data = cursor.fetchone()
        document = {}
    return collection


def juntaClienteFatura(fatura):
    columns = getColumns('Cliente')
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Cliente WHERE id = %s;" % fatura['id_c'])
    cliente = {}

    data = cursor.fetchone()

    for col in columns:
        cliente[col] = data[columns.index(col)]

    fatura['cliente'] = cliente


def juntaFuncionarioFatura(fatura):
    columns = getColumns('Funcionario')
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Funcionario WHERE id = %s;" % fatura['id_func'])
    funcionario = {}

    data = cursor.fetchone()

    for col in columns:
        if col in ['ordenado']:
            funcionario[col] = float(data[columns.index(col)])
        else:
            funcionario[col] = data[columns.index(col)]

    fatura['funcionario'] = funcionario


def juntaMedsFatura(fatura):
    columns = getColumns('Medicamento')
    columns = columns + ['qt_v','preco_v' ,'preco_l']
    cursor = db.cursor()
    cursor.execute("SELECT Medicamento.*, Fatura_Med.qt_v, Fatura_Med.preco_v, Fatura_Med.preco_l FROM Medicamento JOIN Fatura_Med ON Fatura_Med.id_m = Medicamento.id JOIN Fatura ON Fatura.id = Fatura_Med.id_f WHERE Fatura.id = %s;" % fatura['id'])

    meds = []
    med = {}

    data = cursor.fetchone()

    while data is not None:
        for col in columns:
            if col in ['preco', 'qt', 'preco_l', 'preco_v']:
                med[col] = float(data[columns.index(col)])
            else:
                med[col] = data[columns.index(col)]
        meds.append(med)
        med = {}
        data = cursor.fetchone()
    fatura['medicamentos'] = meds


def juntaFaturasFunc(func):
    columns = getColumns('Fatura')
    faturas = []
    cursor = db.cursor()

    cursor.execute("SELECT Fatura.* FROM Fatura JOIN Funcionario ON Funcionario.id = Fatura.id_func WHERE Funcionario.id = %s;" % func['id'])
    
    fatura = {}
    data = cursor.fetchone()
    while data is not None:
        for col in columns:
            if col in ['total', 'desconto']:
                fatura[col] = float(data[columns.index(col)])
            else:
                fatura[col] = data[columns.index(col)]
        juntaClienteFatura(fatura)
        juntaMedsFatura(fatura)
        faturas.append(fatura)
        fatura = {}
        data = cursor.fetchone()
    func['faturas'] = faturas


def juntaFaturasCliente(cliente):
    columns = getColumns('Fatura')
    faturas = []
    cursor = db.cursor()

    cursor.execute("SELECT Fatura.* FROM Fatura JOIN Cliente ON Cliente.id = Fatura.id_c WHERE Cliente.id = %s;" % cliente['id'])
    
    fatura = {}
    data = cursor.fetchone()
    while data is not None:
        for col in columns:
            if col in ['total', 'desconto']:
                fatura[col] = float(data[columns.index(col)])
            else:
                fatura[col] = data[columns.index(col)]
        juntaFuncionarioFatura(fatura)
        juntaMedsFatura(fatura)
        faturas.append(fatura)
        fatura = {}
        data = cursor.fetchone()
    cliente['faturas'] = faturas


def juntaFaturasMed(med):
    columns = getColumns('Fatura')
    faturas = []
    cursor = db.cursor()

    cursor.execute("SELECT Fatura.* FROM Fatura JOIN Fatura_Med ON Fatura.id = Fatura_Med.id_f JOIN Medicamento ON Medicamento.id = Fatura_Med.id_m  WHERE Medicamento.id = %s;" % med['id'])
    
    fatura = {}
    data = cursor.fetchone()
    while data is not None:
        for col in columns:
            if col in ['total', 'desconto']:
                fatura[col] = float(data[columns.index(col)])
            else:
                fatura[col] = data[columns.index(col)]
        juntaFuncionarioFatura(fatura)
        juntaClienteFatura(fatura)
        faturas.append(fatura)
        fatura = {}
        data = cursor.fetchone()
    med['faturas'] = faturas

#cliente: id, telemovel, passe
#fatura: id, data_s, id_func, id_c  //// adicionar nome funcionario
#medicamentos: id, preco, stock, pos 
def remIrrelevant(lista):
    for cliente in lista:
        for k in ['id', 'tlmv', 'pass']:
            del cliente[k]
        for f in cliente['faturas']:
            for k in ['id', 'data_s', 'id_func', 'id_c']:
                del f[k]
            f['nome_func'] = f['funcionario']['nome']
            del f['funcionario']
            for m in f['medicamentos']:
                for k in ['id', 'preco', 'stock', 'pos']:
                    del m[k]




#################################################################################

col = db_mongo['Cliente']
lista = getTable('Cliente')
remIrrelevant(lista)
col.insert_many(lista)

























