with 
    source_contas as (
        select *
        from {{ source('bap_data', 'contas') }}    
    )
    
    , contas as (
        select 
           Num_conta as id_conta
           , Cod_cliente as id_cliente
           , data_abertura as data_abertura_conta
           , Saldo_total as saldo_conta
           , Saldo_disponivel as saldo_disponivel
           , FORMAT_DATE('%d-%m-%Y', DATE(Data_ultimo_lancamento)) AS data_ultimo_lancamento
        --    , Data_ultimo_lancamento as Data_ultimo_lancamento
        from source_contas
    )

select *
from contas