import MySQLdb
import random
import datetime

db = MySQLdb.connect("localhost","root","random1998","farmacia")
cursor = db.cursor()
date = datetime.datetime(2018, 4, 28)

for i in range(100000):
    if i % 1000 == 0:
        print(i)
    id_fat = i + 16 #i am lazy
    cursor.execute("INSERT INTO Fatura (id, data_f, data_s, pontos_r, pontos_u, desconto, total, id_func, id_c) VALUES ('%d', '%s', '%s', '%d', '%d', '%f', '%f', '%d', '%d');"% (id_fat, date, date, 0, 0, 0.0, 0.0, random.randint(1,4), random.randint(1,7)))
    #db.commit()
    nrandom = random.randint(1,4)
    added_meds = []
    for i in range(nrandom):
        med = random.randint(1,6)
        while med in added_meds:
            med = random.randint(1,6)
        added_meds.append(med)
        cursor.execute("INSERT INTO Fatura_Med (id_f, id_m, qt_v, preco_v, preco_l) VALUES ('%d', '%d', '%f', '%f', '%f');" % (id_fat, med, random.randint(1,4), 0, 0))
        #db.commit()

db.commit()
