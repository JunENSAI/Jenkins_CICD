import os
import urllib.parse
from sqlalchemy import create_engine, text


def test_database_connection():

    db_user = os.getenv('DB_USER')
    db_pass = urllib.parse.quote_plus(os.getenv('DB_PASS'))
    db_name = os.getenv('DB_NAME')

    db_string = f"postgresql+psycopg2://{db_user}:{db_pass}@localhost:5432/{db_name}"

    engine = create_engine(db_string)

    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1;"))
        value = result.fetchone()[0]

        # Expect 1
        assert value == 1
        