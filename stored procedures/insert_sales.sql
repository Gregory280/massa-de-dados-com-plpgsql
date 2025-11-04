CREATE OR REPLACE PROCEDURE store_dataset.insert_sales()
LANGUAGE plpgsql
AS $$
DECLARE

	i INT;
	num_sales INT;

	customer RECORD;
	quantity INT;
    sale_value DECIMAL(10, 2);
    sale_date DATE;

BEGIN

	FOR customer IN SELECT customer_id FROM store_dataset.customers LOOP
		num_sales := trunc(random() * 5 + 1)::INT;

		FOR i IN 1..num_sales LOOP
			sale_value := trunc(random() * 10000 + 500)::DECIMAL;
			quantity := trunc(random() * 10 + 1)::INT;
			sale_date := '2021-01-01'::DATE + (trunc(random() * (365 * 5))::INT);
			
			INSERT INTO store_dataset.sales (
				customer_id, quantity, sale_value, sale_date	
			) VALUES (
				customer.customer_id, quantity, sale_value, sale_date
			);
		END LOOP;
	END LOOP;
END;
$$;

CALL store_dataset.insert_sales();