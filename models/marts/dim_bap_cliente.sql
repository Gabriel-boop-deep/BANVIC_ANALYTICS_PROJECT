with 
    clientes as (
        select *
        from {{ ref('stg_bap_clientes') }}
    )

    , dim_cliente as (
        select
            clientes.id_cliente
            , clientes.nome_cliente
            , clientes.sobrenome_cliente
            , clientes.email_cliente
            , clientes.data_inclusao
            , clientes.endereco_cliente
            , clientes.cep_cliente
            
        from clientes
    )

    , dim_cliente_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['email_cliente','id_cliente']) }} as cliente_sk,
            *
        from dim_cliente
    )

select *
from dim_cliente_sk