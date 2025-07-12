USE library_db;

INSERT INTO members (member_id, member_type, join_date) VALUES
(1, 'student', '2024-06-01'),
(2, 'staff', '2023-09-15'),
(3, 'student', '2024-02-10'),
(4, 'staff', '2022-11-20'),
(5, 'student', '2025-01-05');

INSERT INTO returns (return_id, borrow_id, return_date, fine_amount) VALUES
(1, 1, '2024-06-10', 0.00),
(2, 2, '2024-06-11', 10.00),
(3, 3, '2024-06-12', 5.00),
(4, 4, '2024-06-13', 0.00),
(5, 5, '2024-06-14', 15.00);

INSERT INTO borrows (borrow_id, user_id, book_id, borrow_date, due_date, returns_return_id) VALUES
(1, 1, 1, '2024-06-01', '2024-06-07', 1),
(2, 2, 2, '2024-06-02', '2024-06-08', 2),
(3, 3, 3, '2024-06-03', '2024-06-09', 3),
(4, 4, 4, '2024-06-04', '2024-06-10', 4),
(5, 5, 5, '2024-06-05', '2024-06-11', 5);

INSERT INTO fines (fine_id, user_id, amount, reason, paid_status) VALUES
(1, 1, 0.00, NULL, 'paid'),
(2, 2, 10.00, 'Late return', 'unpaid'),
(3, 3, 5.00, 'Minor damage', 'paid'),
(4, 4, 0.00, NULL, 'paid'),
(5, 5, 15.00, 'Lost book', 'unpaid');

INSERT INTO accounts (account_id, user_id, total_fines_paid, balance) VALUES
(1, 1, 0.00, 100.00),
(2, 2, 20.00, 50.00),
(3, 3, 10.00, 75.00),
(4, 4, 5.00, 80.00),
(5, 5, 30.00, 60.00);

INSERT INTO users (user_id, name, email, password, role, members_member_id, borrows_borrow_id, fines_fine_id, accounts_account_id) VALUES
(1, 'Rahul Sharma', 'rahul@example.com', 'pass123', 'student', 1, 1, 1, 1),
(2, 'Priya Verma', 'priya@example.com', 'pass234', 'staff', 2, 2, 2, 2),
(3, 'Aman Singh', 'aman@example.com', 'pass345', 'student', 3, 3, 3, 3),
(4, 'Neha Kapoor', 'neha@example.com', 'pass456', 'staff', 4, 4, 4, 4),
(5, 'Karan Mehta', 'karan@example.com', 'pass567', 'student', 5, 5, 5, 5);

INSERT INTO books (book_id, title, author, isbn, total_copies, available_copies, borrows_borrow_id) VALUES
(1, 'Atomic Habits', 'James Clear', '9780735211292', 10, 7, 1),
(2, 'The Alchemist', 'Paulo Coelho', '9780061122415', 8, 4, 2),
(3, 'Deep Work', 'Cal Newport', '9781455586691', 6, 3, 3),
(4, 'Rich Dad Poor Dad', 'Robert Kiyosaki', '9781612680194', 12, 9, 4),
(5, 'The Psychology of Money', 'Morgan Housel', '9789390166268', 15, 10, 5);

