import os
import urllib.parse
from sqlalchemy import create_engine, text

# 1. Setup Connection
db_user = os.getenv('DB_USER')
db_pass = urllib.parse.quote_plus(os.getenv('DB_PASS'))
db_name = os.getenv('DB_NAME')
db_string = f"postgresql+psycopg2://{db_user}:{db_pass}@localhost:5432/{db_name}"

engine = create_engine(db_string)

# 2. Define the Table (SQL)
sql_create_table = text("""
    CREATE TABLE IF NOT EXISTS jenkins_audit (
        id SERIAL PRIMARY KEY,
        run_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        message TEXT
    );
""")

# 3. Insert a Record
sql_insert_log = text("INSERT INTO jenkins_audit (message) VALUES ('Jenkins Pipeline Ran Successfully');")

# 4. Execute
with engine.connect() as connection:
    print("--- Creating Table (if not exists) ---")
    connection.execute(sql_create_table)
    
    print("--- Inserting Deployment Log ---")
    connection.execute(sql_insert_log)
    
    connection.commit()
    print("SUCCESS: Database updated.")