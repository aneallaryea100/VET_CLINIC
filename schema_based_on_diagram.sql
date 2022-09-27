CREATE DATABASE clinic;

CREATE TABLE patients(
    id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY (id) );

    CREATE TABLE medical_histories (
         id INT NOT NULL,
         admitted_at TIMESTAMP NOT NULL,
         patient_id INT,
         status VARCHAR(200), 
         PRIMARY KEY (id),
         CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES patients(id) 
         );

    CREATE TABLE treatments (
        id INT NOT NULL,
        type VARCHAR(200) NOT NULL,
        name VARCHAR(200) NOT NULL,
        PRIMARY KEY (id) );

         CREATE TABLE invoices (
        id INT NOT NULL,
        total_amount DECIMAL NOT NULL,
        generated_at TIMESTAMP NOT NULL,
        payed_at TIMESTAMP NOT NULL,
        medical_history_id INT NOT NULL,
        CONSTRAINT fk_medical_invoice FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
        PRIMARY KEY (id) );

    
    CREATE TABLE invoice_items (
        id INT NOT NULL,
        unit_price DECIMAL NOT NULL,
        quantity INT NOT NULL,
        total_price DECIMAL NOT NULL,
        invoice_id INT NOT NULL,
        treatment_id INT NOT NULL,
        CONSTRAINT fk_invoice_item FOREIGN KEY (invoice_id) REFERENCES invoice(id),
        CONSTRAINT fk_invoice_treatment FOREIGN KEY (treatment_id) REFERENCES treatment(id) 
        );

   
    