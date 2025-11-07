CREATE OR REPLACE FUNCTION store_dataset.relatorio_vendas_por_dias(qty_days_param INT)
RETURNS TABLE (
	info TEXT,
	total_vendas BIGINT,
	total_valor MONEY,
	maior_valor MONEY
) AS $$
	
BEGIN
	RETURN QUERY
	SELECT
		'Resumo dos últimos ' || qty_days_param || ' dias' AS INFO,
		COUNT(SALE_ID) AS TOTAL_VENDAS,
		SUM(QUANTITY * SALE_VALUE)::MONEY AS TOTAL_VALOR,
		MAX(QUANTITY * SALE_VALUE)::MONEY AS MAIOR_VALOR 
	FROM
		STORE_DATASET.SALES
	WHERE
		SALE_DATE >= CURRENT_DATE - (qty_days_param || ' days')::INTERVAL;
END;
$$ LANGUAGE plpgsql;

-- Relatório dos últimos 30 dias
SELECT * FROM  store_dataset.relatorio_vendas_por_dias(30)