import mysql.connector

def connect_db():
    return mysql.connector.connect(
        host="localhost",  
        user="root",  
        password="Prmsql@143",  
        database="LibraryManagement1"
    )

def return_book(book_id):
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.callproc("ReturnBook", (book_id,))
        conn.commit()
        print(f"Success: Book {book_id} returned.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    book_id = int(input("Enter Book ID to return: "))
    return_book(book_id)
