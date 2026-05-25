CREATE TABLE Publishers (
    publisher_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT uq_publisher_name UNIQUE (name) 
);

CREATE TABLE Book_Status (
    status_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL,
    CONSTRAINT uq_book_status_name UNIQUE (status_name)
);

CREATE TABLE Book_Location (
    location_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room SMALLINT NOT NULL,
    row SMALLINT NOT NULL,
    cabinet SMALLINT NOT NULL,
    shelf SMALLINT NOT NULL,
    CONSTRAINT chk_location_room CHECK (room > 0),
    CONSTRAINT chk_location_row CHECK (row > 0),
    CONSTRAINT chk_location_cabinet CHECK (cabinet > 0),
    CONSTRAINT chk_location_shelf CHECK (shelf > 0)
);

CREATE TABLE Book_Copies (
    copy_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INT NOT NULL,
    status_id INT NOT NULL,
    location_id INT NOT NULL,
    publication_year SMALLINT NOT NULL,
    publisher_id INT NOT NULL,
    CONSTRAINT chk_publication_year CHECK (publication_year BETWEEN 1000 AND 9999)
);

ALTER TABLE Book_Copies 
    ADD CONSTRAINT fk_bookcopies_book 
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE;

ALTER TABLE Book_Copies 
    ADD CONSTRAINT fk_bookcopies_status 
    FOREIGN KEY (status_id) REFERENCES Book_Status(status_id) ON DELETE RESTRICT;

ALTER TABLE Book_Copies 
    ADD CONSTRAINT fk_bookcopies_location 
    FOREIGN KEY (location_id) REFERENCES Book_Location(location_id) ON DELETE RESTRICT;

ALTER TABLE Book_Copies 
    ADD CONSTRAINT fk_bookcopies_publisher 
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) ON DELETE RESTRICT;

CREATE INDEX idx_book_copies_book_id ON Book_Copies(book_id);
CREATE INDEX idx_book_copies_status_id ON Book_Copies(status_id);
