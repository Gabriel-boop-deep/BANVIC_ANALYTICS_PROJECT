with 
    propostas_credito as (
        select *
        from {{ ref('stg_bap_propostas_credito') }}   
    )

    , stg_conta as (
        select *
        from {{ ref('stg_bap_contas') }}  
    )

    , stg_agencia as (
        select *
        from {{ ref('stg_bap_colaborador_agencia')}}
    )
    
    , int_propostas_credito as (
        select
           sa.id_agencia
           ,sc.id_conta  
           ,spc.id_cliente
           ,spc.id_proposta  
           ,spc.id_colaborador  
           ,spc.taxa_juros_mensal
           ,spc.valor_financiamento
           ,spc.valor_entrada
           ,spc.valor_prestacao
           ,sc.saldo_conta
           ,sc.saldo_disponivel
           ,spc.status_proposta
           ,spc.data_proposta
           ,sc.data_abertura_conta
        from propostas_credito spc
        left join stg_conta sc
            on sc.id_cliente = spc.id_cliente
        left join stg_agencia sa
            on sa.id_colaborador = spc.id_colaborador

    )

select *
from int_propostas_credito