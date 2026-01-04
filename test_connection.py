import os
import pytest
from sqlalchemy import create_engine, text
import urllib.parse

def test_database_connection():
    # 1. Setup the connection
    db_user = os.getenv('DB_USER')
    db_pass = urllib.parse.quote_plus(os.getenv('DB_PASS'))
    db_name = os.getenv('DB_NAME')
    
    db_string = f"postgresql+psycopg2://{db_user}:{db_pass}@localhost:5432/{db_name}"
    
    # 2. Connect
    engine = create_engine(db_string)
    
    # 3. Assert
    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1;"))
        value = result.fetchone()[0]

        assert value == 1