/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight, neutered, escape_attempts)
VALUES
	('Agumon', '2020-02-03', 10.23, true, 0),
	('Gabumon', '2018-11-15', 8, true, 2),
	('Pikachu', '2021-01-07', 15.04, false, 1),
	('Devimon', '2017-05-12', 11, true, 5);

/* Add new data to the table */

INSERT INTO animals (name, date_of_birth, weight, neutered, escape_attempts)
VALUES
	('Charmander', '2020-02-08', -11, false, 0),
	('Plantmon', '2021-11-15', -5.7, true, 2),
	('Squirtle', '1993-04-02', -12.13, false, 3),
	('Angemon', '2005-06-12', -45, true, 1),
	('Boarmon', '2005-06-07', 20.4, true, 7),
 	('Blossom', '1998-10-13', 17, true, 3),
	('Ditto', '2022-05-14', 22, true, 4);