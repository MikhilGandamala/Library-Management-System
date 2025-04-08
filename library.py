import mysql.connector

def connect_db():
    return mysql.connector.connect(
        host="localhost",  # Change this to your MySQL server
        user="root",  # Change this to your MySQL username
        password="Prmsql@143",  # Change this to your MySQL password
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

def run_tests():
    print("\n--- Running Positive and Negative Test Cases ---\n")
    
    # Positive Test Cases
    print("[+] Borrowing a book successfully...")
    borrow_book(1, 1, 1)  # Borrow Book 1 for Member 1
    
    print("[+] Returning the book within due date...")
    return_book(1)  # Return Book 1 (No fine expected)
    
    # Negative Test Cases
    print("[-] Trying to borrow a non-existing book...")
    borrow_book(1, 999, 1)  # Book 999 does not exist
    
    print("[-] Trying to borrow an already issued book...")
    borrow_book(2, 1, 1)  # Book 1 is already issued
    
    print("[-] Trying to return a book that was never borrowed...")
    return_book(999)  # Book 999 was never issued
    
    print("[-] Returning a book late (Fine should be applied)...")
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE Issue SET DueDate = DATE_SUB(CURDATE(), INTERVAL 5 DAY) WHERE IssueID = 1")
    conn.commit()
    cursor.close()
    conn.close()
    return_book(1)  # Returning late, so fine should be applied

if __name__ == "__main__":
    run_tests()
