-- Inserted data into the animals table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

-- Branch database-transactions
-- Inserted data into the animals table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
  ('Charmander', '2020-02-08', 0, false, -11),
  ('Plantmon', '2021-11-15', 2, true, -5.7),
  ('Squirtle', '1993-04-02', 3, false, -12.13),
  ('Angemon', '2005-06-12', 1, true, -45),
  ('Boarmon', '2005-06-07', 7, true, 20.4),
  ('Blossom', '1998-10-13', 3, true, 17),
  ('Ditto', '2022-05-14', 4, true, 22);

-- Transaction 1
-- Start the transaction
BEGIN;
-- Update the animals table, setting the species column to 'unspecified'
UPDATE animals SET species = 'unspecified';
-- Verify the change
SELECT * FROM animals;
-- Rollback the transaction
ROLLBACK;
-- Verify that the species column went back to the state before the transaction
SELECT * FROM animals;

-- Transaction 2
-- Start the transaction
BEGIN;
-- Update the species column to 'digimon' for animals with names ending in 'mon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update the species column to 'pokemon' for animals without a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
-- Verify the changes
SELECT * FROM animals;
-- Commit the transaction
COMMIT;
-- Verify that changes persist after commit
SELECT * FROM animals;

-- Transaction 3
-- Start the transaction
BEGIN;
-- Delete all records in the animals table
DELETE FROM animals;
-- Verify that records are deleted within the transaction
SELECT * FROM animals;
-- Rollback the transaction
ROLLBACK;
-- Verify that all records in the animals table still exist after the rollback
SELECT * FROM animals;

-- Transaction 4
-- Start the transaction
BEGIN;
-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
-- Create a savepoint
SAVEPOINT my_savepoint;
-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO my_savepoint;
-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
-- Commit the transaction
COMMIT;


