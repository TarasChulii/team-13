-- ================================================================
-- ================================================================
-- ================================================================

SET search_path TO team13;

/*=========================================================
-- FUNCTION 1
-- Get total number of books in the system
--=========================================================--*/

CREATE OR REPLACE FUNCTION get_total_books()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM books;
    RETURN total;
END;
$$;

-- Test
--SET search_path TO team13;
--SELECT get_total_books();

-- ================================================================
-- ================================================================
-- ================================================================

SET search_path TO team13;

/* =========================================================
-- FUNCTION 2
-- Check if a book is available (has at least one free copy)
-- Input: book_id
-- Output: BOOLEAN
--=========================================================--*/

CREATE OR REPLACE FUNCTION is_book_available(p_book_id INT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE available BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM book_copies bc
        WHERE bc.book_id = p_book_id
          AND bc.status_id = 1   -- assuming 1 = available
    )
    INTO available;

    RETURN available;
END;
$$;

-- Test
--SET search_path TO team13;
--SELECT is_book_available(1);

-- =========================================================
-- =========================================================
-- =========================================================

SET search_path TO team13;

/*=========================================================
-- FUNCTION 3
-- Get average rating of a book
-- Input: book_id
-- Output: NUMERIC
-- ========================================================= --*/

CREATE OR REPLACE FUNCTION get_book_average_rating(p_book_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE avg_rating NUMERIC;
BEGIN
    SELECT COALESCE(AVG(rating), 0)
    INTO avg_rating
    FROM reviews
    WHERE book_id = p_book_id;

    RETURN avg_rating;
END;
$$;

-- Test
--SET search_path TO team13;
--SELECT get_book_average_rating(1);

-- =========================================================
-- =========================================================
-- =========================================================

SET search_path TO team13;

/*=========================================================
-- PROCEDURE 1 (INSERT)
-- Add new member
-- ========================================================= --*/

CREATE OR REPLACE PROCEDURE add_member(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_phone VARCHAR,
    p_address VARCHAR,
    p_email VARCHAR,
    p_status_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO members(first_name, last_name, phone, address, email, member_status_id)
    VALUES (p_first_name, p_last_name, p_phone, p_address, p_email, p_status_id);
END;
$$;

-- Test
/*
SET search_path TO team13;
CALL add_member(
    'Ivan', 'Petrenko',
    '+380 (50) 123-45-67',
    'Kyiv',
    'ivan@example.com',
    1
);
select * from members
where first_name = 'Ivan';
--*/

-- =========================================================
-- =========================================================
-- =========================================================

SET search_path TO team13;

/*=========================================================
-- PROCEDURE 2 (SELECT)
-- Get member Name and Email by ID
-- =========================================================--*/

CREATE OR REPLACE PROCEDURE get_user_email_by_id(
    IN p_id INT,
    OUT o_first_name varchar,
    OUT o_last_name varchar,
    OUT o_email varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT first_name, last_name, email
    INTO o_first_name, o_last_name, o_email
    FROM members
    WHERE member_id = p_id;
END;
$$;

-- Test
--SET search_path TO team13;
--CALL get_user_email_by_id(1, NULL, NULL, NULL);

-- =========================================================
-- =========================================================
-- =========================================================

SET search_path TO team13;

/*=========================================================
-- PROCEDURE 2.1 (SELECT via CURSOR)
-- Get member info by ID
-- =========================================================*/

CREATE OR REPLACE PROCEDURE get_user_info_by_id(
    IN p_id INT,
    INOUT p_ref REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_ref FOR
    SELECT *
    FROM members
    WHERE member_id = p_id;
END;
$$;

--Test
/*
SET search_path TO team13;
BEGIN;
CALL get_user_info_by_id(2, 'member_cursor');
FETCH ALL FROM member_cursor;
COMMIT;
--*/

-- =========================================================
-- =========================================================
-- =========================================================

SET search_path TO team13;

/*=========================================================
-- PROCEDURE 3 (UPDATE)
-- Update member email
-- =========================================================--*/

CREATE OR REPLACE PROCEDURE update_member_email(
    p_member_id INT,
    p_new_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE members
    SET email = p_new_email
    WHERE member_id = p_member_id;
END;
$$;

-- Test
/*
SET search_path TO team13;
select * from members where member_id = 1;
CALL update_member_email(1, 'new_email@example.com');
select * from members where member_id = 1;
--*/

-- =========================================================
-- =========================================================
-- =========================================================

SET search_path TO team13;

/*=========================================================
-- PROCEDURE 4 (UPDATE)
-- Update book copy status
-- =========================================================--*/

CREATE OR REPLACE PROCEDURE update_book_copy_status(
    p_copy_id INT,
    p_status_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE book_copies
    SET status_id = p_status_id
    WHERE copy_id = p_copy_id;
END;
$$;

-- Test
/*
SET search_path TO team13;
select * from book_copies where copy_id = 1;
CALL update_book_copy_status(1, 2);
select * from book_copies where copy_id = 1;
--*/

-- =========================================================
-- =========================================================
-- =========================================================