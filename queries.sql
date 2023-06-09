/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon'; /* selected animals whose name ends with 'mon' */
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'; /* selected animals born between 2016 and 2019 */
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3; /* selected animals that are neutered and have less than 3 escape attempts */
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'; /* selected date of birth of Agumon and Pikachu */
SELECT name, escape_attempts FROM animals WHERE weight > 10.5; /* selected name and escape attempts of animals that weight more than 10.5 */
SELECT * FROM animals WHERE neutered = true; /* selected animals that are neutered */
SELECT * FROM animals WHERE name <> 'Gabumon'; /* selected animals that are not Gabumon */
SELECT * FROM animals WHERE weight BETWEEN 10.4 AND 17.3; /* selected animals that weight between 10.4 and 17.3 */

/* Set a begin, then update the species of all animals to 'unspecified' and rollback the changes. */

BEGIN; /* begin the transaction */

UPDATE Animals /* select which table to update */
SET species = 'unspecified'; /* set the species of all animals to 'unspecified' */

ROLLBACK; /* rollback the changes */

BEGIN;

UPDATE Animals 
SET species = 'Digimon' /* set the species of all animals to 'Digimon' */
WHERE name LIKE '%mon'; /* select animals whose name ends with 'mon' */

UPDATE Animals
SET species = 'Pokemon' /* set the species of all animals to 'Pokemon' */
WHERE species IS NULL; /* select animals whose species is null */

COMMIT; /* commit the changes */

BEGIN; /* begin the transaction */

DELETE FROM Animals; /* delete all animals */

ROLLBACK; /* rollback the changes */

BEGIN;

DELETE FROM Animals 
WHERE date_of_birth > '2022-01-01'; /* delete animals born after 2022 */

SAVEPOINT checkpoint; /* create a savepoint */

UPDATE Animals
SET weight = weight * -1; /* set the weight of all animals to negative */

ROLLBACK TO checkpoint; /* rollback the changes to the savepoint */

UPDATE Animals
SET weight = weigh * -1; /* set the weight of all animals to negative */
WHERE weight < 0; /* select animals whose weight is negative */

COMMIT; /* commit the changes */

SELECT COUNT(*) FROM Animals; /* count the number of animals */
SELECT COUNT(*) FROM Animals WHERE escape_attempts > 0; /* count the number of animals that have '0' escape attempts */
SELECT AVG(weight) FROM Animals;  /* calculate the average weight of all animals */
SELECT neutered, COUNT(*)  FROM animals WHERE escape_attempts > 0 GROUP BY neutered; /* calculate which escapes the most, neutered or not neutered */
SELECT species, MIN(weight), MAX(weight) FROM Animals GROUP BY species; /* calculate the minimum and maximum weight of each species */
SELECT species, AVG(escape_attempts) FROM Animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species; /* calculate the average escape attempts of animals born between 1990 and 2000 */

/* [1] What animals belong to Melody Pond? */
SELECT animals.name FROM animals /* select the name of all animals */
JOIN owners ON animals.owners_id = owners.id /* join the owners table on the owners_id of animals */
JOIN species ON animals.species_id = species.id /* join the species table on the species_id of animals */
WHERE owners.full_name = 'Melody Pond'; /* select the name of all animals owned by Melody Pond */

/* [2] List of all animals that are pokemon (their type is Pokemon) */
SELECT animals.name FROM Animals /* select the name of all animals */
JOIN species ON animals.species_id = species.id /* join the species table on the species_id of animals */ 
WHERE species.name = 'Pokemon'; /* select the name of all Pokemon */

/* [3] List all owners and their animals, remember to include those that don't own any animal. */
SELECT owners.full_name, animals.name /* select the full name of all owners and the name of their animals */
FROM owners /* select the owners table */
LEFT JOIN animals ON owners.id = animals.owners_id; /* join the animals table on the owners_id of animals */

/* [4] How many animals are there per species? */
SELECT species.name, COUNT(animals.id) AS animal_count /* select the name of all species and the number of animals of each species */
FROM animals /* select the animals table */
JOIN species ON animals.species_id = species.id /* join the species table on the species_id of animals */
GROUP BY species.name; /* group the results by the name of the species */

/* [5] List all Digimon owned by Jennifer Orwell */
SELECT animals.name FROM animals /* select the name of all animals */
join owners ON animals.owners_id = owners.id /* join the owners table on the owners_id of animals */
join species ON animals.species_id = species.id /* join the species table on the species_id of animals */
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon'; /* select the name of all Digimon owned by Jennifer Orwell */

/* [6] List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name FROM animals /* select the name of all animals */
join owners ON animals.owners_id = owners.id /* join the owners table on the owners_id of animals */
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0; /* select the name of all animals owned by Dean Winchester that have 0 escape attempts */

/* [7] Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.id) AS total_animals FROM owners /* select the full name of all owners and the number of animals they own */
JOIN animals ON owners.id = animals.owners_id /* join the animals table on the owners_id of animals */
GROUP BY owners.full_name /* group the results by the full name of the owners */
ORDER BY total_animals DESC /* order the results by the number of animals in descending order */
LIMIT 1; /* limit the results to 1 */

/* Queries for Join Tables */

/* [1] Who was the last animal seen by William Tatcher? */
SELECT animals.name, visits.visit_date /* select the name of all animals and the date of their visits */
FROM visits /* select the visits table */
JOIN animals ON animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON vet_id = vets.id /* join the vets table on the vet_id of visits */
WHERE vets.name = 'William Tatcher' /* select the name of all animals seen by William Tatcher */
ORDER BY visit_date DESC /* order the results by the date of the visits in descending order */
LIMIT 1; /* limit the results to 1 */

/* [2] How many different animals did Stephanie Mendez see? */
SELECT COUNT(DISTINCT animals.name) AS animal_count /* select the number of different animals seen by Stephanie Mendez */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON visits.vet_id = vets.id /* join the vets table on the vet_id of visits */
WHERE vets.name = 'Stephanie Mendez'; /* select the number of different animals seen by Stephanie Mendez */

/* [3] List all vets and their specialties, including vets with no specialties. */
SELECT vets.name, specializations.species_id /* select the name of all vets and the species_id of their specializations */
FROM vets /* select the vets table */
LEFT JOIN specializations ON vets.id = specializations.vet_id /* join the specializations table on the vet_id of specializations */
ORDER BY vets.name; /*  order the results by the name of the vets */

/* [4] List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name AS animal_name /* select the name of all animals */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON visits.vet_id = vets.id /* join the vets table on the vet_id of visits */
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30'; /* select the name of all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */

/* [5] What animal has the most visits to vets? */
SELECT animals.name AS animals_name, COUNT(*) as visits_count /* select the name of all animals and the number of visits to vets */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
GROUP BY animals.name /* group the results by the name of the animals */
ORDER BY visits_count DESC /* order the results by the number of visits in descending order */
LIMIT 1; /* limit the results to 1 */

/* [6] Who was Maisy Smith's first visit? */
SELECT animals.name, visits.visit_date /* select the name of all animals and the date of their visits */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON visits.vet_id = vets.id /* join the vets table on the vet_id of visits */
WHERE vets.name = 'Maisy Smith' /* select the name of all animals seen by Maisy Smith */
ORDER BY visits.visit_date /* order the results by the date of the visits */
LIMIT 1; /* limit the results to 1 */

/* [7] Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date /* select the name of all animals, the name of all vets and the date of their visits */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON visits.vet_id = vets.id /* join the vets table on the vet_id of visits */
ORDER BY visits.visit_date DESC /* order the results by the date of the visits in descending order */
Limit 1;

/* [8] How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(*) as visits_count /* select the number of visits */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON visits.vet_id = vets.id /* join the vets table on the vet_id of visits */
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id /* join the specializations table on the vet_id and species_id of specializations */
WHERE specializations.vet_id IS NULL; /* select the number of visits with a vet that did not specialize in that animal's species */

/* [9] What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT species.name AS species_name /* select the name of all species */
FROM visits /* select the visits table */
JOIN animals ON visits.animal_id = animals.id /* join the animals table on the animal_id of visits */
JOIN vets ON visits.vet_id = vets.id /* join the vets table on the vet_id of visits */
JOIN species ON animals.species_id = species.id /* join the species table on the species_id of animals */
WHERE vets.name = 'Maisy Smith' /* select the name of all animals seen by Maisy Smith */
GROUP BY species.name /* group the results by the name of the species */
ORDER BY COUNT(*) DESC /* order the results by the number of visits in descending order */
LIMIT 1; /* limit the results to 1 */


EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

EXPLAIN ANALYZE SELECT vet_id FROM visits where vet_id = 2;

CREATE INDEX idx_vet_id ON visits (vet_id);
WHERE vet_id <> 1 AND vet_id <> 3 AND vet_id <> 4; /* Exclude vet_id 1, 3 and 4 from the index */

/* create INDEX for on visits where vet_id is 2 */
CREATE INDEX idx_vet_id ON visits (vet_id) WHERE vet_id = 2;

CREATE INDEX idx_email ON owners (email); /* create an index on the email column of the owners table */

REINDEX INDEX idx_vet_id; /* reindex the index */

SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'visits'; /* check the created indexes */


