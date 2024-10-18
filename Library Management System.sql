-- Create the database
CREATE DATABASE library;

-- Use the library database
USE library;

-- Create Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

-- Create Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(10),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

-- Create Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Create ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Insert values into Branch
INSERT INTO Branch VALUES (101, 1, 'Main St', '1234567890');
INSERT INTO Branch VALUES (102, 2, 'Elm St', '0987654321');

-- Insert values into Employee
INSERT INTO Employee VALUES (1, 'John Doe', 'Manager', 60000, 101);
INSERT INTO Employee VALUES (2, 'Jane Smith', 'Librarian', 50000, 101);
INSERT INTO Employee VALUES (3, 'Robert Brown', 'Assistant', 45000, 102);

-- Insert values into Books
INSERT INTO Books VALUES (1111, 'History of Time', 'Science', 30.00, 'Yes', 'Stephen Hawking', 'Bantam Books');
INSERT INTO Books VALUES (1112, 'Data Science Handbook', 'Technology', 45.00, 'No', 'Jake VanderPlas', 'O\'Reilly Media');
INSERT INTO Books VALUES (1113, 'Modern History', 'History', 25.00, 'Yes', 'Paul Johnson', 'Harper');

-- Insert values into Customer
INSERT INTO Customer VALUES (201, 'Alice White', 'Maple St', '2021-05-10');
INSERT INTO Customer VALUES (202, 'David Black', 'Oak St', '2022-03-11');
INSERT INTO Customer VALUES (203, 'Sophia Green', 'Pine St', '2023-02-01');

-- Insert values into IssueStatus
INSERT INTO IssueStatus VALUES (301, 201, 'History of Time', '2023-06-10', 1111);
INSERT INTO IssueStatus VALUES (302, 202, 'Data Science Handbook', '2023-06-15', 1112);

-- Insert values into ReturnStatus
INSERT INTO ReturnStatus VALUES (401, 201, 'History of Time', '2023-07-01', 1111);

-- Queries

-- 1. Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending order of salary
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books
SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

-- 4. Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from book table containing 'history'
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 1 employees
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 1;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses
SELECT Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;
