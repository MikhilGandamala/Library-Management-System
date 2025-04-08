import mysql.connector

def connect_db():
    return mysql.connector.connect(
        host="localhost",  
        user="root",  
        password="Prmsql@143",  
        database="LibraryManagement1"
    )

def borrow_book(member_id, book_id, librarian_id):
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.callproc("BorrowBook", (member_id, book_id, librarian_id))
        conn.commit()
        print(f"Success: Book {book_id} borrowed by Member {member_id}")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    member_id = int(input("Enter Member ID: "))
    book_id = int(input("Enter Book ID: "))
    librarian_id = int(input("Enter Librarian ID: "))
    borrow_book(member_id, book_id, librarian_id)
