/*Queries that provide answers to the questions from all projects.*/

-- Query 1: Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- Query 2: List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- Query 3: List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- Query 4: List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- Query 5: List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Query 6: Find all animals that are neutered
SELECT * FROM animals WHERE neutered = TRUE;

-- Query 7: Find all animals not named Gabumon
SELECT * FROM animals WHERE name NOT IN ('Gabumon');

-- Query 8: Find all animals with a weight between 10.4kg and 17.3kg (including the animals with weights equal to precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Branch database-transactions Queries
-- Query 1: How many animals are there?
SELECT COUNT(*) AS total_animals
FROM animals;

-- Query 2: How many animals have never tried to escape?
SELECT COUNT(*) AS non_escape_animals
FROM animals
WHERE escape_attempts = 0;

-- Query 3: What is the average weight of animals?
SELECT AVG(weight) AS average_weight
FROM animals;

-- Query 4: Who escapes the most, neutered or not neutered animals?
SELECT neutered AS neutered_status, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered_status;

-- Query 5: What is the minimum and maximum weight of each type of animal?
SELECT species AS animal_type, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY animal_type;

-- Query 6: What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species AS animal_type, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY animal_type;

-- Branch add-join-table 
--Query 1: What animals belong to Melody Pond?
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- Query 2: List of all animals that are Pokemon (their type is Pokemon).
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- Query 3: List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, COALESCE(a.name, 'No animals owned') AS owned_animals
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

-- Query 4: How many animals are there per species?
SELECT s.name AS species, COUNT(a.id) AS num_animals
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

-- Query 5: List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

-- Query 6: List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester';

-- Query 7: Who owns the most animals?
SELECT o.full_name, COUNT(a.id) AS num_animals_owned
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY num_animals_owned DESC
LIMIT 1;