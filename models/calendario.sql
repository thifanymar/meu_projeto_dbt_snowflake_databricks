{{ config(materialized='table', alias='dim_calendario', schema='dim11') }}

with datas as (
    select
        min(DT_INTER) as data_min_inter,
        max(DT_INTER) as data_max_inter,
        min(DT_SAIDA) as data_min_saida,
        max(DT_SAIDA) as data_max_saida
    from {{ source('base_limpa', 'CLEAN_DADOS') }}
),

datas_gerais as (
    select
        least(data_min_inter, data_min_saida) as data_min,
        greatest(data_max_inter, data_max_saida) as data_max
    from datas
),

-- Gerar todas as datas entre data_min e data_max
numeros as (
    select
        row_number() over (order by seq4()) - 1 as n
    from table(generator(rowcount => 100000)) -- ajusta esse número para seu range
),

calendario as (
    select
        dateadd(day, n, data_min) as data_calendario
    from datas_gerais
    join numeros
        on dateadd(day, n, data_min) <= data_max
)

select
    data_calendario,
    year(data_calendario) as ano,
    month(data_calendario) as mes,
    day(data_calendario) as dia,
    dayofweekiso(data_calendario) as dia_semana,
    weekiso(data_calendario) as semana_ano,
    quarter(data_calendario) as trimestre
from calendario
order by data_calendario
