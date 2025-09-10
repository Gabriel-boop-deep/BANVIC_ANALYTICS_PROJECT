with 
    dim_agencia as (
        select *
        from {{ ref('dim_bap_agencia') }}
    )

    , dim_cliente as (
        select *
        from {{ ref('dim_bap_cliente') }}
    )

    , dim_colaborador as (
        select *
        from {{ ref('dim_bap_colaborador') }}
    )

    , dim_dates as (
        select *
        from {{ ref('dim_dates') }} 
    )

    , stg_transacoes as (
        select *
        from {{ ref('stg_bap_transacoes') }}
    )

    , fact_table as (
        select *
        from {{ ref('int_bap_proposta') }}
    )

    , transacoes_filtradas as (
        select *
        from (
            select *,
                   row_number() over (partition by id_conta order by data_transacao desc) as rn
            from stg_transacoes
        )
        where rn = 1
    )

    , joined_table as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fact_table.id_conta',
                'fact_table.id_proposta',
                'dim_cliente.cliente_sk',
                'dim_agencia.agencia_sk'
            ]) }} as transacao_sk

            , transacoes_filtradas.id_transacao
            , fact_table.id_conta
            , dim_cliente.cliente_sk as cliente_fk
            , dim_agencia.agencia_sk as agencia_fk
            , dim_colaborador.colaborador_sk as colaborador_fk

            , transacoes_filtradas.data_transacao
            , dim_dates.metric_date as data_fk
            , transacoes_filtradas.tipo_transacao
            , transacoes_filtradas.valor_transacao

            , fact_table.saldo_conta
            , fact_table.saldo_disponivel
            , fact_table.data_proposta
            , fact_table.data_abertura_conta
            , fact_table.valor_financiamento
            , fact_table.valor_entrada
            , fact_table.valor_prestacao
            , fact_table.taxa_juros_mensal
            , fact_table.status_proposta
        from fact_table
        left join dim_cliente
            on dim_cliente.id_cliente = fact_table.id_cliente
        left join dim_agencia
            on dim_agencia.id_agencia = fact_table.id_agencia
        left join dim_colaborador
            on dim_colaborador.id_colaborador = fact_table.id_colaborador
                and dim_colaborador.id_agencia = fact_table.id_agencia
        left join transacoes_filtradas
            on transacoes_filtradas.id_conta = fact_table.id_conta
        left join dim_dates
            on dim_dates.metric_date = date(fact_table.data_proposta)
    )

    , fact_transacoes as (
        select
            transacao_sk
            , cliente_fk
            , agencia_fk
            , colaborador_fk
            , data_fk
            , id_transacao
            , id_conta
            , data_transacao
            , tipo_transacao
            , valor_transacao
            , saldo_conta
            , saldo_disponivel
            , data_abertura_conta
            , data_proposta
            , valor_financiamento
            , valor_entrada
            , valor_prestacao
            , taxa_juros_mensal
            , status_proposta
            , valor_transacao * taxa_juros_mensal as custo_financeiro_estimado
        from joined_table
    )

select *
from fact_transacoes