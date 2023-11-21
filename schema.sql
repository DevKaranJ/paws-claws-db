/* Database schema to keep the structure of entire database. */

-- Created the animals table
CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

-- Branch database-transactions
-- Add the "species" column to the "animals" table
ALTER TABLE animals
ADD species VARCHAR(255);