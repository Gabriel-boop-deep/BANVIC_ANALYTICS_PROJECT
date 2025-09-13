with 
    source_clientes as (
        select *
        from {{ source('bap_data', 'clientes') }}    
    )
    
    , clientes as (
        select 
           Cod_cliente as id_cliente
        --    ELECT
           , FORMAT_DATE('%Y-%m-%d', DATE(Data_inclusao)) AS data_inclusao
           , Primeiro_nome as nome_cliente
           , Ultimo_nome as sobrenome_cliente
           , Email as email_cliente
           , Endereco as endereco_cliente
           , Cep as cep_cliente

        from source_clientes
    )

select *
from clientes