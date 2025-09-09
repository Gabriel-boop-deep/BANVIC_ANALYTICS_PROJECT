with 
    source_propostas_credito as (
        select *
        from {{ source('bap_data', 'propostas_credito') }}    
    )
    
    , propostas_credito as (
        select 
           Cod_proposta as id_proposta
           , Cod_cliente as id_cliente
           , Cod_colaborador as id_colaborador
           , Taxa_juros_mensal as taxa_juros_mensal
           , Valor_financiamento as valor_financiamento
           , Valor_entrada as valor_entrada
           , Valor_prestacao as valor_prestacao
           , Status_proposta as status_proposta
           , Data_entrada_proposta as data_proposta
        from source_propostas_credito
    )

select *
from propostas_credito