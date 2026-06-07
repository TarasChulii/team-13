/*=========================================================================
=========================== Taras Chulii ==================================
===========================================================================*/
SET search_path TO team13;

/*============================================================================
    1. HORIZONTAL VIEW
    Purpose:
    Shows only book titles and ISBN numbers.
    Demonstrates column selection without filtering rows.
    Useful for public catalog listings where only basic book information should be visible.
    ============================================================================--*/

CREATE OR REPLACE VIEW tc_book_catalog_horizontal_view AS
SELECT title, isbn
FROM books;

/*============================================================================
    2. HORIZONTAL VIEW WITH JOIN
    Purpose:
    Displays book titles and author names.
    Demonstrates column projection from multiple related tables.
    Useful for library catalog searches.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_books_and_authors_horizontal_with_join_view AS
SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author_name
FROM books b JOIN books_authors ba
ON b.book_id = ba.book_id JOIN authors a
ON ba.author_id = a.author_id;

 /*============================================================================
    3. VERTICAL VIEW
    Purpose:
    Displays only overdue borrowings.
    Demonstrates row filtering using conditions.
    Useful for librarians monitoring overdue books.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_overdue_borrowings_vertical_view AS
SELECT *
FROM borrowings
WHERE due_date < CURRENT_DATE
AND return_date IS NULL;

/*============================================================================
    4. MIXED VIEW
    Purpose:
    Displays only active members and selected contact information.
    Demonstrates both row filtering and column selection.
    Useful for communication and membership management.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_active_members_mixed_view AS
SELECT member_id, first_name, last_name, phone, email
FROM members
WHERE member_status_id =
( SELECT member_status_id
FROM member_status
WHERE name = 'Active');

 /*============================================================================
    5. JOIN VIEW
    Purpose:
    Shows members and books they currently borrowed.
    Demonstrates joining multiple tables.
    Core reporting view for library operations.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_member_borrowings_join_view AS
SELECT m.member_id, CONCAT(m.first_name, ' ', m.last_name) AS member_name,
b.title, br.borrow_date, br.due_date, br.return_date
FROM borrowings br 
JOIN members m ON br.member_id = m.member_id
JOIN book_copies bc ON br.copy_id = bc.copy_id
JOIN books b ON bc.book_id = b.book_id;

 /*============================================================================
    6. COMPLEX JOIN VIEW
    Purpose:
    Provides detailed information about book copies,  their locations, publishers, and statuses.
    Useful for inventory management.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_library_inventory_complex_join_view AS
SELECT bc.copy_id, b.title, cs.name AS copy_status,
p.name AS publisher, bc.publication_year, bl.room_number,
bl.row_number, bl.cabinet_number, bl.shelf_number
FROM book_copies bc
JOIN books b ON bc.book_id = b.book_id
JOIN copy_status cs ON bc.status_id = cs.status_id
JOIN publishers p ON bc.publisher_id = p.publisher_id
JOIN book_location bl ON bc.location_id = bl.location_id;

 /*============================================================================
    7. SUBQUERY VIEW
    Purpose:
    Displays books with average rating above 4.
    Demonstrates aggregate calculations through subqueries.
    Useful for recommendation systems and featured books.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_highly_rated_books_subquery_view AS
SELECT b.book_id, b.title,
ROUND((SELECT AVG(r.rating) FROM reviews r WHERE r.book_id = b.book_id),2) AS average_rating
FROM books b
WHERE (SELECT AVG(r.rating) FROM reviews r WHERE r.book_id = b.book_id) > 4;

 /*============================================================================
    8. UNION VIEW
    Purpose:
    Combines active and completed reservations into one view.
    Demonstrates UNION ALL operation.
    Useful for reservation history reporting.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_all_reservations_union_view AS

SELECT reservation_id, member_id, book_id,
reservation_date, 'Current Reservation' AS reservation_group
FROM reservations
WHERE reservation_status_id = 1

UNION ALL

SELECT reservation_id, member_id, book_id,
reservation_date, 'Past Reservation' AS reservation_group
FROM reservations
WHERE reservation_status_id <> 1;

 /*============================================================================
    9. VIEW BASED ON ANOTHER VIEW
    Purpose:
    Summary view built from tc_member_borrowings_join_view.
    Demonstrates view layering.
    Useful for management reports.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_borrowing_summary_based_on_view AS
SELECT member_id, member_name, COUNT(*) AS books_borrowed
FROM tc_member_borrowings_join_view
GROUP BY member_id, member_name;

 /*============================================================================
    10. VIEW WITH CHECK OPTION
    Purpose:
    Allows updates only on available book copies.
    Prevents modifications that would move rows outside  the view definition.
    Demonstrates an updatable view with integrity protection.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_available_book_copies_with_check_view AS
SELECT copy_id, book_id, status_id, location_id, publication_year, publisher_id
FROM book_copies
WHERE status_id = (SELECT status_id FROM copy_status WHERE name = 'Available')
WITH CHECK OPTION;

 /*============================================================================
    11. MANAGEMENT DASHBOARD VIEW
    Purpose:
    Aggregated statistics for each book.
    Demonstrates GROUP BY and aggregation.
    Useful for analytics and administration.
 ============================================================================--*/

CREATE OR REPLACE VIEW tc_book_statistics_view AS
SELECT b.book_id, b.title,
COUNT(DISTINCT bc.copy_id) AS total_copies,
COUNT(DISTINCT rv.review_id) AS total_reviews,
ROUND(AVG(rv.rating), 2) AS average_rating
FROM books b
LEFT JOIN book_copies bc ON b.book_id = bc.book_id
LEFT JOIN reviews rv ON b.book_id = rv.book_id
GROUP BY b.book_id, b.title;

/*============================================================================
============================================================================--*/
