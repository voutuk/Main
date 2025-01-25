import psycopg2

def test_postgres_connection(db_name, user, password, host='localhost', port=5432):
    """
    Перевіряє можливість з'єднання з PostgreSQL.
    Повертає True, якщо з'єднання успішне, інакше False.
    """
    try:
        connection = psycopg2.connect(
            dbname=db_name,
            user=user,
            password=password,
            host=host,
            port=port
        )
        print("Connection to PostgreSQL is successful!")
        connection.close()
        return True
    except Exception as e:
        print(f"Error connecting to PostgreSQL: {e}")
        return False

if __name__ == "__main__":
    # Змініть параметри на реальні значення
    db_connected = test_postgres_connection(
        db_name="olxDb",
        user="olxapi",
        password="*dmUntdOidd3d_#WTi4B9ZoZp%rSDj4Imds07djc*",
        host="localhost",    # або IP сервера
        port=5022            # порт, прокинутий у docker-compose (5022:5432)
    )
    if db_connected:
        print("PostgreSQL login test passed.")
    else:
        print("PostgreSQL login test failed.")
