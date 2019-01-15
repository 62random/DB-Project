import time 
import MySQLdb
from pymongo import MongoClient


mysql_db = MySQLdb.connect("localhost", "root", "random1998", "farmacia")

mongo_db = MongoClient('mongodb://localhost')[farmacia]





start = time.time()
##fazer algo na mysql
end = time.time()

print("mysql: " + end - start)


start = time.time()
##fazer algo na mongo
end = time.time()

print("mongodb: " + end - start)

