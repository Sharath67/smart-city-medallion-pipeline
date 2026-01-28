import psycopg2

conn = psycopg2.connect(
    host="localhost",
    port="5432",
    dbname="smart_city_dw",    
    user="postgres",
    password="Yourpassword"
)
