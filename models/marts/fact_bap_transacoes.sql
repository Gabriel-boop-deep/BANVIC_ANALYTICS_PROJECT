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

    , stg_contas as (
        select *
        from {{ ref('stg_bap_contas') }}
    )

    , stg_propostas_u as (
        select *
        from {{ ref('stg_bap_propostas_credito') }}
    )

    , joined_table as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'stg_transacoes.id_transacao',
                'stg_contas.id_conta',
                'dim_cliente.cliente_sk',
                'dim_agencia.agencia_sk'
            ]) }} as transacao_sk

            , stg_transacoes.id_transacao
            , stg_transacoes.id_conta
            , dim_cliente.cliente_sk as cliente_fk
            , dim_agencia.agencia_sk as agencia_fk
            , dim_colaborador.colaborador_sk as colaborador_fk
            , dim_dates.metric_date as data_fk
            , stg_transacoes.data_transacao
            , stg_transacoes.tipo_transacao
            , stg_transacoes.valor_transacao

            , stg_contas.saldo_conta
            , stg_contas.saldo_disponivel
            , stg_contas.data_abertura_conta

            , stg_propostas_u.valor_financiamento
            , stg_propostas_u.valor_entrada
            , stg_propostas_u.valor_prestacao
            , stg_propostas_u.taxa_juros_mensal
            , stg_propostas_u.status_proposta
        from stg_transacoes
        left join stg_contas
            on stg_transacoes.id_conta = stg_contas.id_conta
        left join dim_cliente
            on stg_contas.id_cliente = dim_cliente.id_agencia
        left join dim_agencia
            on dim_cliente.id_agencia = dim_agencia.id_agencia
        left join stg_propostas_u
            on stg_contas.id_cliente = stg_propostas_u.id_cliente
        left join dim_colaborador
            on stg_propostas_u.id_colaborador = dim_colaborador.id_colaborador
        left join dim_dates
            on stg_transacoes.data_transacao = FORMAT_DATE('%d-%m-%Y', dim_dates.metric_date)
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