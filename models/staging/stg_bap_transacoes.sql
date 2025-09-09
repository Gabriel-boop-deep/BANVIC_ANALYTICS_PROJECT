with 
    source_transacoes as (
        select *
        from {{ source('bap_data', 'transacoes') }}    
    )
    
    , transacoes as (
        select 
           Cod_transacao as id_transacao
           , Num_conta as id_conta
           , FORMAT_DATE('%d-%m-%Y', DATE(Data_transacao)) AS data_transacao
           , Nome_transacao as tipo_transacao
           , Valor_transacao as valor_transacao
        from source_transacoes
    )

select *
from transacoes