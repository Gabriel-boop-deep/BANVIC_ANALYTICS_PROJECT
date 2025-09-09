with 
    source_colaborador_agencia as (
        select *
        from {{ source('bap_data', 'colaborador_agencia') }}    
    )
    
    , colaborador_agencia as (
        select 
           Cod_colaborador as id_colaborador
           , Cod_agencia as id_agencia
        from source_colaborador_agencia
    )

select *
from colaborador_agencia