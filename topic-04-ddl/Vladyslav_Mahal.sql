CREATE SCHEMA IF NOT EXISTS library;

CREATE TABLE library.categories (
  category_id bigserial PRIMARY KEY,
  name varchar(100) NOT NULL
);

CREATE TABLE library.authors (
  author_id bigserial PRIMARY KEY,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  biography text
);

CREATE TABLE library.books (
  book_id bigserial PRIMARY KEY,
  title varchar(255) NOT NULL,
  isbn varchar(13) UNIQUE NOT NULL,
  category_id bigint REFERENCES library.categories(category_id) ON DELETE SET NULL
);

CREATE TABLE library.books_authors (
  author_id bigint REFERENCES library.authors(author_id) ON DELETE CASCADE,
  book_id bigint REFERENCES library.books(book_id) ON DELETE CASCADE,
  PRIMARY KEY (author_id, book_id)
);