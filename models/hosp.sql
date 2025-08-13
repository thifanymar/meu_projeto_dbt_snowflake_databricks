{{ config(
    materialized='table',
    alias='dim_hospital',schema='dim11'
) }}

with distinct_dim as (
    select distinct
        UF_ZI,
        CGC_HOSP,
        GESTAO,
        MUNIC_MOV
    from {{ source('base_limpa', 'CLEAN_DADOS') }}
),

dim_com_sk as (
    select
        row_number() over (order by UF_ZI, CGC_HOSP, GESTAO, MUNIC_MOV) as sk_hospital,
        UF_ZI,
        CGC_HOSP,
        GESTAO,
        MUNIC_MOV
    from distinct_dim
)

select * from dim_com_sk