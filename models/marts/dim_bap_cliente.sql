with 
    clientes as (
        select *
        from {{ ref('stg_bap_clientes') }}
    )

    , dim_cliente as (
        select
            clientes.id_agencia,
            clientes.nome_cliente,
            clientes.sobrenome_cliente,
            clientes.email_cliente,
            clientes.data_inclusao
        from clientes
    )

    , dim_cliente_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_agencia', 'email_cliente']) }} as cliente_sk,
            *
        from dim_cliente
    )

select *
from dim_cliente_sk