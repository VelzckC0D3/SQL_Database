/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id SERIAL PRIMARY KEY, /* Primary key that identifies each object in the table. */
	name varchar(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT NOT NULL DEFAULT 0,
	neutered BOOLEAN DEFAULT false,
	wight FLOAT NOT NULL DEFAULT 0
);

/* Add a new column to the table */

ALTER TABLE animals /* select the table to be altered */
ADD COLUMN species VARCHAR; /* add a new column to the table */