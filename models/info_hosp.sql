{{ config(
    materialized='table',
    alias='dim_informacoes_hospitalares',schema='dim11'
) }}

with distinct_dim as (
    select distinct
        MARCA_UTI,
        ESPEC,
        IDENT,
        COBRANCA,
        CAR_INT,
        NATUREZA
    from {{ source('base_limpa', 'CLEAN_DADOS') }}
),

dim_com_sk as (
    select
        row_number() over (order by MARCA_UTI, ESPEC, IDENT, COBRANCA, CAR_INT, NATUREZA) as sk_informacoes_hospitalares,
        MARCA_UTI,
        ESPEC,
        IDENT,
        COBRANCA,
        CAR_INT,
        NATUREZA
    from distinct_dim
)

select * from dim_com_sk
