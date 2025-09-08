with 
    colaboradores as (
        select *
        from {{ ref('stg_bap_colaborador') }}
    )

    , dim_colaborador as (
        select
            colaboradores.id_colaborador,
            colaboradores.nome_colaborador,
            colaboradores.cpf_colaborador
        from colaboradores
    )

    , dim_colaborador_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_colaborador']) }} as colaborador_sk,
            *
        from dim_colaborador
    )

select *
from dim_colaborador_sk