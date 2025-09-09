with 
    colaboradores as (
        select *
        from {{ ref('stg_bap_colaborador') }}
    )

    , colaborador_agencia as (
        select *
        from {{ ref('stg_bap_colaborador_agencia') }}
    )

    , dim_colaborador as (
        select
            colaboradores.id_colaborador
            , colaborador_agencia.id_agencia
            , colaboradores.nome_colaborador
            , colaboradores.cpf_colaborador
        from colaboradores
        left join colaborador_agencia
            on colaboradores.id_colaborador = colaborador_agencia.id_colaborador
    )

    , dim_colaborador_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_colaborador']) }} as colaborador_sk,
            *
        from dim_colaborador
    )

select *
from dim_colaborador_sk