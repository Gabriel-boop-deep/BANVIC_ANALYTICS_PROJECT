with 
    source_colaboradores as (
        select *
        from {{ source('bap_data', 'colaboradores') }}    
    )
    
    , colaboradores as (
        select 
           Cod_colaborador as id_colaborador
           , Primeiro_nome as nome_colaborador
           , Cpf as cpf_colaborador
        from source_colaboradores
    )

select *
from colaboradores