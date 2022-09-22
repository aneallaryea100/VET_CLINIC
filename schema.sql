/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(200) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutured BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL );

    ALTER TABLE animals
    ADD species VARCHAR(200);



-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer

CREATE TABLE owners (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name varchar(200) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (id) );

--     Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string

CREATE TABLE species (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(200) NOT NULL,
    PRIMARY KEY (id) );

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

     ALTER TABLE animals
    ADD PRIMARY KEY (id),
    DROP species,
    ADD COLUMN species_id INT,
    ADD CONSTRAINT fk_animals_species, 
    FOREIGN KEY (species_id) REFERENCES species (id);

    ALTER TABLE animals
    ADD COLUMN owner_id INT
    ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners (id);
