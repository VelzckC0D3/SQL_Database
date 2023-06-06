/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id SERIAL PRIMARY KEY,
	name varchar(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT NOT NULL DEFAULT 0,
	neutered BOOLEAN DEFAULT false,
	wight FLOAT NOT NULL DEFAULT 0
);