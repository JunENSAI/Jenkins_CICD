from sqlalchemy import create_engine, text
import os
import sys
import urllib.parse

raw_password = os.environ['DB_PASS']
safe_password = urllib.parse.quote_plus(raw_password)

# Format: postgresql+psycopg2://user:password@host:port/dbname
db_string = "postgresql+psycopg2://{}:{}@localhost:5432/{}".format(
    os.environ['DB_USER'],
    safe_password,  # <--- We use the encoded password here
    os.environ['DB_NAME']
)

try:
    print("--- ATTEMPTING CONNECTION ---")
    engine = create_engine(db_string)

    with engine.connect() as connection:
        result = connection.execute(text("SELECT version();"))
        version = result.fetchone()[0]
        
        print(f"SUCCESS: Connected via SQLAlchemy!")
        print(f"Database Version: {version}")

except Exception as e:
    print(f"CRITICAL FAILURE: {e}")
    sys.exit(1)