with 
    transacoes as (
        select *
        from {{ ref('stg_bap_transacoes') }}
    )

    , dim_transacoes as (
        select
            transacoes.id_transacao
            , transacoes.id_conta
            , transacoes.data_transacao
            , transacoes.tipo_transacao
            , transacoes.valor_transacao
        from transacoes
    )

    , dim_transacoes_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['id_transacao']) }} as transacao_sk,
            *
        from dim_transacoes
    )

select *
from dim_transacoes_sk