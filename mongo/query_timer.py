import time 
import MySQLdb
from pymongo import MongoClient
from bson import SON

mysql_db = MySQLdb.connect("localhost", "root", "random1998", "farmacia")
cursor = mysql_db.cursor()

mongo_db = MongoClient('mongodb://localhost')['farmacia']
col = mongo_db['Cliente']


#############################################################
#############################################################
#############################################################
#                       QUERIES                             #
#############################################################
#############################################################
#############################################################



###########Doentes Cronicos #################################

mysql_cronicos = " SELECT c.nome as Nome_Cliente, m.des as Nome_Med, COUNT(id_m) as N_Compras FROM Fatura as f INNER JOIN Fatura_Med AS fm ON f.id=fm.id_f INNER JOIN Cliente AS c ON c.id=f.id_c INNER JOIN Medicamento AS m ON m.id=fm.id_m WHERE m.des = 'Sinvastatina' GROUP BY f.id_c,fm.id_m HAVING (COUNT(id_m))>=5;"
mongo_cronicos = [
    {
        "$unwind": "$faturas"
    },
    {
        "$unwind": "$faturas.medicamentos"
    },
    
    {
        "$group": {
            "_id": {
                "medicine": "$faturas.medicamentos.des",
                "client": "$nome"
            },
            "count": { "$sum": 1 }
        }
    },
    {
        "$match": {
            "count": { "$gte": 5 }
        }
    },
    {
        "$project": {
            "_id": 0,
            "clientName": "$_id.client",
            "medicineName": "$_id.medicine",
            "count": 1
        }
    },
    {
        "$match": {"medicineName": "Sinvastatina"}
    }
] 

mysql_pontos = "SELECT SUM(Fatura.pontos_r) FROM Fatura JOIN Cliente ON Cliente.id = Fatura.id_c WHERE Cliente.id = 1;"
mongo_pontos = [
  {
    "$match": {"nome": "Carminho Cunha Bastos"}
  },
  {
    "$unwind": "$faturas"
  },
  {
    "$group": {
      "_id": "$nome",
      "count": 
        {
          "$sum": "$faturas.pontos_r"
        }
    }
  }
]


mysql_faturacao = "select sum(total) from Fatura JOIN Cliente ON Cliente.id = Fatura.id_c WHERE Cliente.id = 1 AND data_f > '2018-03-31' AND data_f < '2018-04-31';"

mongo_faturacao = [
  {
      "$match": {"nome": "Joao da Costa e Campos"}
  },
  {
    "$unwind": "$faturas"
  },
  {
    "$match": {'faturas.data_f':{
                "$lt": "ISODate(\"2018-04-30T00:00:00Z\")",
                "$gt": "ISODate(\"2018-03-31T19:31:01.279Z\")"
          }}
  },
  {
    "$group": {
      "_id": "$nome",
      "count": 
        {
          "$sum": "$faturas.total"
        }
    }
  }
]


mysql_faturas = "select * from Fatura  inner join Cliente on id_c = Cliente.id and  id_c = 7;"
mongo_faturas = ({
    "nome": "Carminho Cunha Bastos"
  },
  {
    "nome":1,
    "faturas":1,
    "_id":0
  }
)

####################################################################



s1 = '---------------------- QUERY TIMER --------------------------'
s2 = '-------------------------------------------------------------'
s3 = '------------------- PACIENTES CRONICOS ----------------------'
s4 = '-------------------- TODAS AS FATURAS -----------------------'
s5 = '--------------------- PONTOS TOTAIS -------------------------'
s6 = '------------------- FATURACAO MENSAL ------------------------'





print(s1)
print(s3)

media = 0
for i in range(10):
    start = time.time()
    cursor.execute(mysql_cronicos)
    end = time.time()
    media += end - start
mysql_time = media/10
print("mysql: " + str(mysql_time))

media = 0
for i in range(10):
    start = time.time()
    mongo_db.things.aggregate(mongo_cronicos)
    end = time.time()
    media += end - start
mongo_time = media/10
print("mongodb: " + str(mongo_time))
print("ratio mysql/mongo: " + str(mysql_time/mongo_time))

print(s4)

media = 0
for i in range(10):
    start = time.time()
    cursor.execute(mysql_faturas)
    end = time.time()
    media += end - start
mysql_time = media/10
print("mysql: " + str(mysql_time))

media = 0
for i in range(10):
    start = time.time()
    mongo_db.things.find(mongo_faturas[0], mongo_faturas[1])
    end = time.time()
    media += end - start
mongo_time = media/10
print("mongodb: " + str(mongo_time))
print("ratio mysql/mongo: " + str(mysql_time/mongo_time))


print(s5)

media = 0
for i in range(10):
    start = time.time()
    cursor.execute(mysql_pontos)
    end = time.time()
    media += end - start
mysql_time = media/10
print("mysql: " + str(mysql_time))

media = 0
for i in range(10):
    start = time.time()
    mongo_db.things.aggregate(mongo_pontos)
    end = time.time()
    media += end - start
mongo_time = media/10
print("mongodb: " + str(mongo_time))
print("ratio mysql/mongo: " + str(mysql_time/mongo_time))


print(s6)

media = 0
for i in range(10):
    start = time.time()
    cursor.execute(mysql_faturacao)
    end = time.time()
    media += end - start
mysql_time = media/10
print("mysql: " + str(mysql_time))

media = 0
for i in range(10):
    start = time.time()
    mongo_db.things.aggregate(mongo_faturacao)
    end = time.time()
    media += end - start
mongo_time = media/10
print("mongodb: " + str(mongo_time))
print("ratio mysql/mongo: " + str(mysql_time/mongo_time))


print(s2)

