with 
    agencias as (
        select *
        from {{ ref('stg_bap_agencias') }}
    )

    , dim_agencia as (
        select
            agencias.id_agencia,
            agencias.nome_agencia,
            agencias.data_abertura,
            agencias.tipo_agencia
        from agencias
    )

    , dim_agencia_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_agencia']) }} as agencia_sk,
            *
        from dim_agencia
    )

select *
from dim_agencia_sk