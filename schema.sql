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

CREATE TABLE owners ( /* create a new table */
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(50) NOT NULL,
	age INT NOT NULL
);

CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

ALTER TABLE animals ADD species_id int REFERENCES species(id); /* add a foreign key to the table */
ALTER TABLE ANIMALS ADD owners_id int REFERENCES owners(id); /* add a foreign key to the table */

CREATE TABLE vets(
	id SERIAL PRIMARY KEY,
	name varchar(20) NOT NULL,
	age integer NOT NULL,
	date_of_graduation date NOT NULL
);

CREATE TABLE specializations(
	species_id int REFERENCES species(id), /* add a foreign key to the table */
	vet_id int REFERENCES vets(id) /* add a foreign key to the table */
);

CREATE TABLE visits(
	animal_id int REFERENCES animals(id), /* add a foreign key to the table */
	vet_id int REFERENCES vets(id), /* add a foreign key to the table */
	visit_date date NOT NULL
)

/* Add an email column to your owners table */
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

 /* create an index on the table */
CREATE INDEX idx_animal_id ON visits (animal_id);