{{ config(
    materialized='table',
    alias='dim_paciente',schema='dim11'
) }}

with distinct_dim as (
    select distinct
        CEP,
        MUNIC_RES,
        NASC,
        SEXO,
        COD_IDADE,
        IDADE,
        NACIONAL,
        NUM_FILHOS,
        INSTRU,
        MORTE
    from {{ source('base_limpa', 'CLEAN_DADOS') }}
),

dim_com_sk as (
    select
        row_number() over (
            order by CEP, MUNIC_RES, NASC, SEXO, COD_IDADE, IDADE, NACIONAL, NUM_FILHOS, INSTRU, MORTE
        ) as sk_paciente,
        CEP,
        MUNIC_RES,
        NASC,
        SEXO,
        COD_IDADE,
        IDADE,
        NACIONAL,
        NUM_FILHOS,
        INSTRU,
        MORTE
    from distinct_dim
)

select * from dim_com_sk
