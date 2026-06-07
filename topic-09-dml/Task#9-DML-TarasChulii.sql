/*=========================================================================
=========================== Taras Chulii ==================================
===========================================================================*/

SET search_path TO team13;

-- Member Status
INSERT INTO member_status (name) VALUES
('Active'),
('Suspended'),
('Expired'),
('Pending'),
('Blocked'),
('VIP'),
('Student'),
('Teacher'),
('Guest');

-- Reservation Status
INSERT INTO reservation_status (name) VALUES
('Active'),
('Completed'),
('Cancelled'),
('Expired'),
('Pending'),
('Collected'),
('Rejected'),
('Processing'),
('Archived');

-- Borrowing Status
INSERT INTO borrowing_status (name) VALUES
('Borrowed'),
('Returned'),
('Overdue'),
('Lost'),
('Damaged'),
('Renewed'),
('Pending'),
('Processing'),
('Closed'),
('Archived');

-- Copy Status
INSERT INTO copy_status (name) VALUES
('Available'),
('Borrowed'),
('Reserved'),
('Lost'),
('Damaged'),
('Repair'),
('Archived'),
('Processing'),
('Reference'),
('Removed');


INSERT INTO categories (name) VALUES
('Science Fiction'),
('Fantasy'),
('Mystery'),
('Romance'),
('History'),
('Biography'),
('Programming'),
('Database'),
('Mathematics'),
('Psychology');

INSERT INTO publishers (name) VALUES
('Penguin Random House'),
('HarperCollins'),
('O''Reilly Media'),
('Packt Publishing'),
('Pearson'),
('Springer'),
('McGraw-Hill'),
('Oxford Press'),
('Cambridge Press'),
('Manning Publications');


INSERT INTO authors(first_name,last_name,biography) VALUES
('Isaac','Asimov','American science fiction writer'),
('J.K.','Rowling','British author'),
('George','Orwell','English novelist'),
('Robert','Martin','Software engineer'),
('Martin','Fowler','Software architect'),
('Thomas','Cormen','Computer scientist'),
('Stephen','King','American writer'),
('Agatha','Christie','Mystery writer'),
('Yuval','Harari','Historian'),
('Daniel','Kahneman','Psychologist');


INSERT INTO members
(first_name,last_name,phone,address,email,member_status_id)
VALUES
('Ivan','Petrenko','+380 (50) 111-22-33',
 'Kyiv, Khreshchatyk 1',
 'ivan.petrenko@email.com',1),

('Olena','Shevchenko','+380 (67) 222-33-44',
 'Kyiv, Volodymyrska 10',
 'olena.shevchenko@email.com',1),

('Andrii','Koval','+380 (93) 333-44-55',
 'Lviv, Svobody Ave 15',
 'andrii.koval@email.com',7),

('Maksym','Bondar','+380 (95) 444-55-66',
 'Odesa, Deribasivska 7',
 'maksym.bondar@email.com',1),

('Tetiana','Moroz','+380 (66) 555-66-77',
 'Dnipro, Central Ave 20',
 'tetiana.moroz@email.com',8),

('Yulia','Tkachenko','+380 (97) 666-77-88',
 'Kharkiv, Nauky Ave 11',
 'yulia.tk@email.com',1),

('Serhii','Melnyk','+380 (68) 777-88-99',
 'Kyiv, Saksahanskoho 5',
 'serhii.m@email.com',2),

('Natalia','Lysenko','+380 (63) 888-99-00',
 'Vinnytsia, Soborna 2',
 'natalia.l@email.com',1),

('Roman','Hrytsenko','+380 (99) 123-45-67',
 'Chernihiv, Shevchenka 3',
 'roman.h@email.com',6),

('Anna','Savchenko','+380 (73) 321-54-76',
 'Poltava, Yevropeiska 12',
 'anna.s@email.com',1);


 INSERT INTO books(title,isbn,category_id) VALUES
('Foundation','9780553293357',1),
('Harry Potter and the Philosopher''s Stone','9780747532699',2),
('1984','9780451524935',1),
('Clean Code','9780132350884',7),
('Refactoring','9780201485677',7),
('Introduction to Algorithms','9780262033848',8),
('The Shining','9780307743657',3),
('Murder on the Orient Express','9780062693662',3),
('Sapiens','9780062316110',5),
('Thinking, Fast and Slow','9780374533557',10);

INSERT INTO book_location
(room_number,row_number,cabinet_number,shelf_number)
VALUES
(1,1,1,1),
(1,1,1,2),
(1,1,2,1),
(1,1,2,2),
(1,2,1,1),
(1,2,1,2),
(2,1,1,1),
(2,1,1,2),
(2,2,1,1),
(2,2,1,2);


INSERT INTO books_authors(author_id,book_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

INSERT INTO book_copies
(book_id,status_id,location_id,publication_year,publisher_id)
VALUES
(1,1,1,2018,1),
(2,1,2,2017,2),
(3,2,3,2016,1),
(4,1,4,2020,3),
(5,2,5,2019,10),
(6,1,6,2021,5),
(7,1,7,2015,2),
(8,3,8,2018,2),
(9,1,9,2019,6),
(10,2,10,2018,8);


INSERT INTO reviews
(member_id,book_id,rating,review_text)
VALUES
(1,1,5,'Excellent science fiction classic'),
(2,2,5,'Magical and engaging'),
(3,3,4,'Thought provoking'),
(4,4,5,'Essential for developers'),
(5,5,4,'Useful software engineering book'),
(6,6,5,'Great academic reference'),
(7,7,4,'Suspenseful story'),
(8,8,5,'Classic mystery'),
(9,9,5,'Very informative'),
(10,10,4,'Interesting psychology insights');


INSERT INTO reservations
(member_id,book_id,reservation_date,reservation_status_id)
VALUES
(1,2,'2025-01-10',1),
(2,3,'2025-01-11',2),
(3,4,'2025-01-12',3),
(4,5,'2025-01-13',1),
(5,6,'2025-01-14',2),
(6,7,'2025-01-15',4),
(7,8,'2025-01-16',5),
(8,9,'2025-01-17',1),
(9,10,'2025-01-18',2),
(10,1,'2025-01-19',1);


INSERT INTO borrowings
(copy_id,member_id,borrow_date,due_date,return_date,borrowing_status_id)
VALUES
(1,1,'2025-02-01','2025-02-15','2025-02-10',2),
(2,2,'2025-02-02','2025-02-16',NULL,1),
(3,3,'2025-02-03','2025-02-17',NULL,3),
(4,4,'2025-02-04','2025-02-18','2025-02-17',2),
(5,5,'2025-02-05','2025-02-19',NULL,1),
(6,6,'2025-02-06','2025-02-20','2025-02-19',2),
(7,7,'2025-02-07','2025-02-21',NULL,1),
(8,8,'2025-02-08','2025-02-22',NULL,1),
(9,9,'2025-02-09','2025-02-23','2025-02-20',2),
(10,10,'2025-02-10','2025-02-24',NULL,1);

/*====================================================================
=================== UPDATE Scripts (Testing) =========================
======================================================================*/

/*
select * from team13.members
where member_id = 1;
-- Member changes status
UPDATE team13.members
SET member_status_id = 2
WHERE member_id = 1;

select * from team13.reservations
where reservation_id = 1;
-- Mark reservation completed
UPDATE team13.reservations
SET reservation_status_id = 2
WHERE reservation_id = 1;

select * from team13.borrowings
where borrowing_id = 2;
-- Return borrowed book
UPDATE team13.borrowings
SET return_date = CURRENT_DATE,
    borrowing_status_id = 2
WHERE borrowing_id = 2;

select * from team13.book_copies
where copy_id = 1;
-- Mark copy as borrowed
UPDATE team13.book_copies
SET status_id = 2
WHERE copy_id = 1;
--*/

/*====================================================================
=================== DELETE Scripts (Testing) =========================
======================================================================*/

/*
select * from team13.reviews
where review_id = 10;
-- Delete review
DELETE FROM team13.reviews
WHERE review_id = 10;

select * from team13.reservations
where reservation_id = 10
order by reservation_id;
-- Delete reservation with archived status
DELETE FROM team13.reservations
WHERE reservation_id = 10;

select * from team13.borrowings
where borrowing_id = 1;
-- Delete borrowing history record
DELETE FROM team13.borrowings
WHERE borrowing_id = 1;
--*/

/*====================================================================
========== Constraint Testing (Expected Failures) ====================
======================================================================*/

/*
SET search_path TO team13;
-- Invalid email
INSERT INTO members
(first_name,last_name,phone,address,email,member_status_id)
VALUES
('Test','User',
 '+380 (50) 111-22-33',
 'Kyiv',
 'invalid-email',
 1);
--*/

/*
-- Invalid rating
SET search_path TO team13;
INSERT INTO reviews
(member_id,book_id,rating)
VALUES (1,2,10);
--*/

/*
-- Due date before borrow date
SET search_path TO team13;
INSERT INTO borrowings
(copy_id,member_id,borrow_date,due_date,borrowing_status_id)
VALUES
(1,1,'2025-05-20','2025-05-10',1);
--*/

/*
-- Duplicate ISBN
SET search_path TO team13;
INSERT INTO books(title,isbn,category_id)
VALUES
('Duplicate Foundation','9780553293357',1);
--*/

/*====================================================================*/
/*====================================================================*/
/*====================================================================*/