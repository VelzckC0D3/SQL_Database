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

INSERT INTO species (name)
VALUES
	('Pokemon'),
	('Digimon');

INSERT INTO owners (name, age)
VALUES
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

UPDATE animals 
SET species_id = CASE /* set the species_id of all animals */
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon') /* if the name of the animal ends with 'mon', set the species_id to the id of Digimon */
    ELSE (SELECT id FROM species WHERE name = 'Pokemon') /* else, set the species_id to the id of Pokemon */
END; /* end the case statement */

UPDATE animals 
SET owners_id = CASE
    WHEN name LIKE 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith') /* if the name of the animal is Agumon, set the owners_id to the id of Sam Smith */
    WHEN name LIKE 'Gabumon' OR name LIKE 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') /* if the name of the animal is Gabumon or Pikachu, set the owners_id to the id of Jennifer Orwell */
    WHEN name LIKE 'Devimon' OR name LIKE 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob') /* if the name of the animal is Devimon or Plantmon, set the owners_id to the id of Bob */
    WHEN name LIKE 'Charmander' OR name LIKE 'Squirtle' OR name LIKE 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond') /* if the name of the animal is Charmander, Squirtle or Blossom, set the owners_id to the id of Melody Pond */
    WHEN name LIKE 'Angemon' OR name LIKE 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester') /* if the name of the animal is Angemon or Boarmon, set the owners_id to the id of Dean Winchester */
END;