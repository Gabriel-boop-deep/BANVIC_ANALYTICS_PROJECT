
with 
    dim_agencia as (
        select *
        from {{ ref('dim_bap_agencia') }}
    ),

    dim_cliente as (
        select *
        from {{ ref('dim_bap_cliente') }}
    ),

    dim_colaborador as (
        select *
        from {{ ref('dim_bap_colaborador') }}
    ),

    dim_dates as (
        select *
        from {{ ref('dim_dates') }}
    ),
    dim_transacoes as (
        select *
        from {{ ref('dim_bap_transacao') }}
    ),

    fact_table as (
        select *
        from {{ ref('int_bap_transacoes') }}
    ),

    joined_table as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fact_table.id_conta',
                'fact_table.id_proposta',
                'dim_cliente.cliente_sk',
                'dim_agencia.agencia_sk',
                'dim_transacoes.transacao_sk',
                'dim_transacoes.data_transacao'
            ]) }} as metric_sk,

            dim_transacoes.id_transacao,
            fact_table.id_conta,
            dim_cliente.cliente_sk as cliente_fk,
            dim_agencia.agencia_sk as agencia_fk,
            dim_colaborador.colaborador_sk as colaborador_fk,
            dim_transacoes.transacao_sk as transacao_sk,

            -- Corrigido: manter como DATE sem FORMAT_DATE
            DATE(dim_transacoes.data_transacao) as data_transacao,
            dim_dates.metric_date as data_fk,

            dim_transacoes.valor_transacao,
            fact_table.saldo_conta,
            fact_table.saldo_disponivel,
            fact_table.data_proposta,
            fact_table.data_abertura_conta,
            fact_table.valor_financiamento,
            fact_table.valor_entrada,
            fact_table.valor_prestacao,
            fact_table.taxa_juros_mensal,
            fact_table.status_proposta
        from fact_table
        left join dim_cliente
            on dim_cliente.id_cliente = fact_table.id_cliente
        left join dim_agencia
            on dim_agencia.id_agencia = fact_table.id_agencia
        left join dim_colaborador
            on dim_colaborador.id_colaborador = fact_table.id_colaborador
            and dim_colaborador.id_agencia = fact_table.id_agencia
        left join dim_dates
            on dim_dates.metric_date = DATE(fact_table.data_abertura_conta)
        left join dim_transacoes
            on dim_transacoes.id_conta = fact_table.id_cliente
    ),

    fact_transacoes as (
        select
            metric_sk,
            transacao_sk,
            cliente_fk,
            agencia_fk,
            colaborador_fk,
            data_fk,
            id_transacao,
            id_conta,
            data_transacao,
            valor_transacao,
            saldo_conta,
            saldo_disponivel,
            data_abertura_conta,
            data_proposta,
            valor_financiamento,
            valor_entrada,
            valor_prestacao,
            taxa_juros_mensal,
            status_proposta,
            valor_transacao * taxa_juros_mensal as custo_financeiro_estimado
        from joined_table
    )

select *
from fact_transacoes
