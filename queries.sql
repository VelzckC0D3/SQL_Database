/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon'; /* selected animals whose name ends with 'mon' */
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'; /* selected animals born between 2016 and 2019 */
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3; /* selected animals that are neutered and have less than 3 escape attempts */
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'; /* selected date of birth of Agumon and Pikachu */
SELECT name, escape_attempts FROM animals WHERE weight > 10.5; /* selected name and escape attempts of animals that weight more than 10.5 */
SELECT * FROM animals WHERE neutered = true; /* selected animals that are neutered */
SELECT * FROM animals WHERE name <> 'Gabumon'; /* selected animals that are not Gabumon */
SELECT * FROM animals WHERE weight BETWEEN 10.4 AND 17.3; /* selected animals that weight between 10.4 and 17.3 */
