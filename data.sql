-- Inserted data into the animals table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

------------------------------------------------------------

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

------------------------------------------------------------

--Branch add-join-table
-- data for the "owners" table
INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- data for the "species" table
INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

-- Update animals to include species_id value
UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN 2 -- If the name ends in "mon," it will be Digimon (species_id = 2)
    ELSE 1 -- All other animals are Pokemon (species_id = 1)
END;


-- Sam Smith owns Agumon:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon:
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

------------------------------------------------------------

--BRANCH join-table
-- Insert data into the vets table
INSERT INTO vets (name, age, date_of_graduation) VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert data into the specializations table
INSERT INTO specializations (vet_id, species_id) VALUES
    (1, 'Pokemon'),
    (3, 'Digimon'),
    (3, 'Pokemon'),
    (4, 'Digimon');

-- Insert data into the visits table
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
    (1, 1, '2020-05-24'),
    (1, 3, '2020-07-22'),
    (2, 4, '2021-02-02'),
    (3, 2, '2020-01-05'),
    (3, 2, '2020-03-08'),
    (3, 2, '2020-05-14'),
    (4, 3, '2021-05-04'),
    (5, 4, '2021-02-24'),
    (6, 1, '2020-08-10'),
    (6, 2, '2021-04-07'),
    (7, 3, '2019-09-29'),
    (8, 4, '2020-10-03'),
    (8, 4, '2020-11-04'),
    (9, 2, '2019-01-24'),
    (9, 2, '2019-05-15'),
    (9, 2, '2020-02-27'),
    (9, 2, '2020-08-03'),
    (10, 3, '2020-05-24'),
    (10, 1, '2021-01-11');