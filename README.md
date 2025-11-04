# Criação de massa de dados em plpgsql
Este projeto apresenta scripts para geração de massa de dados para popular um banco de dados de 3 tabelas que estão conectadas entre si.
O objetivo é aplicar técnicas de programação em banco de dados com SQL e tornar a massa de dados o mais próxima da realidade.

## Estrutura
* Tabela de Clientes (representado por Customer)
  * Customer_id
  * Customer_name
  * Customer_address
  * City
* Tabela de Interações (representado por Customer_Engagements)
  * Engagement_id
  * Customer_id
  * Engagement_type
  * Description
  * Engagement_date
* Tabela de Vendas (representada por Sales)
  * Sale_id
  * Customer_id
  * Quantity
  * Sale_value
  * Sale_date

## Atualizações
- Foi adicionado um fator randômico para embaralhar a ordem de inserção das interações realizadas pelos clientes
