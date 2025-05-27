# config.py

import urllib.parse

class Config:
    DB_SERVER = r"localhost\SQLEXPRESS"
    DB_NAME = "DoceMel"
    DB_USERNAME = "JuanRns"
    DB_PASSWORD = "Miguel0401"

    # Monta a string de conexão para SQLAlchemy com pyodbc e driver do SQL Server
    params = urllib.parse.quote_plus(
        f"DRIVER={{ODBC Driver 17 for SQL Server}};"
        f"SERVER={DB_SERVER};"
        f"DATABASE={DB_NAME};"
        f"UID={DB_USERNAME};"
        f"PWD={DB_PASSWORD};"
        "Trusted_Connection=no;"
    )

    SQLALCHEMY_DATABASE_URI = f"mssql+pyodbc:///?odbc_connect={params}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False