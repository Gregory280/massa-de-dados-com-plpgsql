CREATE
OR REPLACE PROCEDURE STORE_DATASET.INSERT_CUSTOMERS (NUM_ROWS INT DEFAULT 100) 
LANGUAGE PLPGSQL AS $$
DECLARE

	i INT;
	random_name VARCHAR(255);
	random_address VARCHAR(255);
	random_city VARCHAR(255);

	cities TEXT[] := ARRAY[
		'São Paulo', 'Porto Alegre', 'Florianópolis', 'Curitiba', 'Belo Horizonte', 'Rio de Janeiro',
		'Salvador', 'Fortaleza', 'Manaus', 'Recife', 'Goiânia'
	];

BEGIN
	FOR i IN 1..num_rows LOOP

		random_name := 'Cliente_' || i || '_' || chr(trunc(65 + random() * 25)::INT);
		random_address := 'Rua ' || chr(trunc(65 + random() * 25)::INT) || ', ' || trunc(random() * 1000)::TEXT;
		SELECT INTO random_city cities[trunc(random() * array_upper(cities, 1)) + 1] AS city;

		INSERT INTO STORE_DATASET.CUSTOMERS (
			CUSTOMER_NAME, 
			CUSTOMER_ADDRESS, 
			CITY
			) VALUES (
			random_name,
			random_address,
			random_city
			);
	END LOOP;
END;
$$;

CALL STORE_DATASET.INSERT_CUSTOMERS (150);