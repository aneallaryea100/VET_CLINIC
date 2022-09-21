/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name, date_of_birth from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name, neutured, escape_attempts from animals WHERE neutured = true AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutured = true;

SELECT * from animals WHERE name != 'Gabumon';

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
SELECT * FROM animals;
COMMIT;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.

BEGIN;

UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals 
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)

BEGIN;
DELETE * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg  = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg  = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;


-- How many animals are there?
-- How many animals have never tried to escape?
-- What is the average weight of animals?
-- Who escapes the most, neutered or not neutered animals?
-- What is the minimum and maximum weight of each type of animal?
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) FROM animals WHERE neutured = true OR neutured = false;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;
SELECT species, AVG(escape_attempts)  FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
