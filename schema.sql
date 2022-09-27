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


-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date

CREATE TABLE vets (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(200) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL,
    PRIMARY KEY (id) );

    CREATE TABLE specializations (
        species_id INT NOT NULL,
        vets_id INT NOT NULL,
        PRIMARY KEY(species_id, vets_id),
        CONSTRAINT fk_specializations_species FOREIGN KEY (species_id) REFERENCES species(id),
        CONSTRAINT fk_specializations_vets FOREIGN KEY (vets_id) REFERENCES vets(id) );


    CREATE TABLE visits (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE NOT NULL,
    CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id)
);

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES (1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-07-10'),
(6, 2, '2021-04-07'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'),
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-07-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');

CREATE INDEX animal_index ON visits (animal_id);

CREATE INDEX vet_index ON visits (vet_id);

CREATE INDEX email_index ON owners (email);

