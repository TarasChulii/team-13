CREATE TABLE Members (
    member_id INT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    email VARCHAR(100),
    created_date DATE,
    memeber_status_id INT NOT NULL
);

CREATE TABLE Member_Status (
    memebr_staus_id INT,
    status VARCHAR(100) NOT NULL
);

CREATE TABLE Reviews (
    review_id INT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    rating INT,
    review_text TEXT,
    created_date DATE
);

ALTER TABLE Member_Status
    ADD CONSTRAINT pk_member_status PRIMARY KEY (memebr_staus_id);

ALTER TABLE Members
    ADD CONSTRAINT pk_members PRIMARY KEY (member_id);

ALTER TABLE Reviews
    ADD CONSTRAINT pk_reviews PRIMARY KEY (review_id);

ALTER TABLE Members
    ADD CONSTRAINT fk_members_status FOREIGN KEY (memeber_status_id)
        REFERENCES Member_Status(memebr_staus_id);

ALTER TABLE Reviews
    ADD CONSTRAINT fk_reviews_member FOREIGN KEY (member_id)
        REFERENCES Members(member_id);

ALTER TABLE Reviews
    ADD CONSTRAINT fk_reviews_book FOREIGN KEY (book_id)
        REFERENCES Books(book_id); 
