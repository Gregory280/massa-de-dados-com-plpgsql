CREATE OR REPLACE PROCEDURE STORE_DATASET.INSERT_CUSTOMER_ENGAGEMENTS () 
LANGUAGE PLPGSQL AS $$
DECLARE

	i INT;
	customer RECORD;
	eng_qty INT;
	eng_type TEXT;
	eng_description TEXT;
	eng_date DATE;

	eng_types TEXT[] := ARRAY['Email', 'Telefone', 'Reunião', 'Chat', 'WhatsApp'];
	eng_desc TEXT[] := ARRAY[
		'Email enviado com informações do produto',
		'Chamada telefônica para acompanhamento',
		'Reunião agendada para discussão de detalhes',
		'Conversa via chat para suporte técnico',
		'Contato via WhatsApp sobre novas ofertas'
	];

BEGIN

	CREATE TEMP TABLE temp_customer_engagements (
		customer_id INT,
		engagement_type TEXT,
		description TEXT,
		engagement_date DATE
	) ON COMMIT DROP;
	
	FOR customer IN SELECT customer_id FROM store_dataset.customers LOOP
		eng_qty := 1 + trunc(random() * 4);
		
		FOR i IN 1..eng_qty LOOP
			eng_type := eng_types[1 + trunc(random() * array_length(eng_types, 1))];
			eng_description := eng_desc[array_position(eng_types, eng_type)];
			eng_date := '2021-01-01'::DATE + (trunc(random() * (365 * 5))::INT);

			INSERT INTO temp_customer_engagements (
				customer_id, 
				engagement_type,
				description,
				engagement_date
			) VALUES (
				customer.customer_id,
				eng_type,
				eng_description,
				eng_date
			);
		END LOOP;
	END LOOP;

	INSERT INTO store_dataset.customer_engagements (customer_id, engagement_type, description, engagement_date) 
		SELECT customer_id, engagement_type, description, engagement_date
	  	FROM temp_customer_engagements
	  	ORDER BY random();
END;
$$;

CALL store_dataset.insert_customer_engagements()
