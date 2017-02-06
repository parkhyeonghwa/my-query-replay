#!/usr/bin/python
import os, sys
import argparse

ifile=''
ofile=''
dbname=''
parser = argparse.ArgumentParser()
parser.add_argument('-i', metavar='in-file', type=argparse.FileType('rt'), required=True, help='input sqlfile')
#parser.add_argument('-o', metavar='out-file', type=argparse.FileType('wt'), required=True)
parser.add_argument('-d', metavar='database-name', type=str, required=True, help='orginal database name')
parser.add_argument('-n', metavar='new-database-name', type=str, required=False, help='import database name')
try:
    results = parser.parse_args()
    ifile = results.i.name
    dbname = results.d
    newdbname =  results.n or dbname
    ofile = os.path.join(os.path.dirname(ifile),newdbname,'meta',os.path.basename(ifile))

except IOError as e:
    parser.error(str(e))



print ("Input file : %s and output file: %s" % (ifile,ofile))


f = open(ifile)
os.makedirs(os.path.dirname(ofile), exist_ok=True)
nf = open(ofile,"w")
nf.write("/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;\n")
nf.write("/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;\n")
nf.write("/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;\n")
nf.write("/*!40101 SET NAMES utf8 */;\n")
nf.write("/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;\n")
nf.write("/*!40103 SET TIME_ZONE='+00:00' */;\n")
nf.write("/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;\n")
nf.write("/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;\n")
nf.write("/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;\n")
nf.write("/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;\n")


print ('startswith')
print ("-- Current Database: `%s`" % dbname)
print ("-- Host: localhost\tDatabase: %s"% dbname)

#print (lines[lines.index("-- Current Database: `%s`" % dbname):lines.index("-- Current Database: `")+1])
flag = False #toggle portion of the database
ismeta = False #check if it is correct meta file

for line in f.readlines():
    if line.startswith("-- Host: localhost    Database: %s"% dbname):
        flag = True
    elif line.startswith("-- Current Database: `%s`" % dbname):
        flag = True
    elif line.startswith("-- Current Database: `"):
        flag = False
    if (flag == True) and ( line.startswith("USE `%s`" % dbname) or line.startswith("CREATE DATABASE ") or line.startswith("-- Host: localhost    Database: %s"% dbname) ) and newdbname :
        line = line.replace(dbname, newdbname)
        print ("this is meta")
        ismeta = True

    if flag:  nf.write(line) #print (line) nf.write(line)

nf.write("/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;\n")
nf.write("/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;\n")
nf.write("/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;\n")
nf.write("/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;\n")
nf.write("/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;\n")
nf.write("/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;\n")
nf.write("/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;\n")

f.close()
nf.close()

if (ismeta == False):
    print ("Cannot find ddls of the specific database. Please upload correct file.")
    os.remove(ofile)
