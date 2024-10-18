# Library-Management-System--Sql
This is a Library Management System built using MySQL. The system manages books, employees, customers, book issues, and returns within a library. The database consists of multiple tables that store information such as branches, employees, books, customers, and their activities in relation to book issuance and returns.

Database Schema
The database library contains the following tables:

Branch

Branch_no (Primary Key)
Manager_Id
Branch_address
Contact_no
Employee

Emp_Id (Primary Key)
Emp_name
Position
Salary
Branch_no (Foreign Key referencing Branch_no in Branch)
Books

ISBN (Primary Key)
Book_title
Category
Rental_Price
Status (Yes/No based on availability)
Author
Publisher
Customer

Customer_Id (Primary Key)
Customer_name
Customer_address
Reg_date (Registration Date)
IssueStatus

Issue_Id (Primary Key)
Issued_cust (Foreign Key referencing Customer_Id in Customer)
Issued_book_name
Issue_date
Isbn_book (Foreign Key referencing ISBN in Books)
ReturnStatus

Return_Id (Primary Key)
Return_cust (Foreign Key referencing Customer_Id in Customer)
Return_book_name
Return_date
Isbn_book2 (Foreign Key referencing ISBN in Books)
Setup Instructions
To set up this project on your local environment, follow the steps below:

Prerequisites
MySQL installed on your machine
MySQL Workbench or any other SQL editor
Git for cloning the repository
Steps
Clone the repository to your local machine:

bash
Copy code
git clone https://github.com/yourusername/library-management-system.git
cd library-management-system
Open MySQL Workbench or your preferred SQL editor.

Create the Database and Tables:

Copy the SQL code from library_management_system.sql (found in this repository).
Run the script in your SQL editor to create the library database and tables.
Insert Sample Data:

The script also includes sample data inserts for Branch, Employee, Books, Customer, IssueStatus, and ReturnStatus tables.
This will allow you to see how the system functions with real data.
Run Queries:

Queries to retrieve information like available books, employee details, customer transactions, etc., are included in the script.
Use the provided queries to perform different operations within the system.
SQL Queries Overview
The SQL script includes queries to:

Retrieve available books' titles, categories, and rental prices.
List employees and their salaries in descending order.
Retrieve book titles and the customers who issued those books.
Count books by category.
List employees whose salaries are above Rs. 50,000.
List customers who registered before 2022 and haven’t issued any books.
Count employees in each branch.
List customers who issued books in June 2023.
Search for books with titles containing "history."
Display branch numbers with more than 1 employees.
Retrieve branch managers and their respective branch addresses.
List customers who issued books with rental prices higher than Rs. 25.
