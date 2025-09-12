with 
    source_agencia as (
        select *
        from {{ source('bap_data', 'agencias') }}    
    )
    
    , agencia as (
        select 
           Cod_agencia as id_agencia
           , nome as nome_agencia
           , data_abertura
           , tipo_agencia
           , Endereco as endereco_agencia
           , Cidade as cidade_agencia
           , Uf as uf_agencia
        from source_agencia
    )

select *
from agencia