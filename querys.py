import sqlite3

connection = sqlite3.connect('social.db')
cursor = connection.cursor()

query = "SELECT * FROM User;"
cursor.execute(query)

results = cursor.fetchall()
for row in results:
    print(row)

connection.close()
