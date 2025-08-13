{{ config(
    materialized='table',
    alias='clean_datasus_sih'
) }}

with dados_transformados as (
    select
        to_date(DT_INTER, 'yyyyMMdd') as DT_INTER,
        to_date(DT_SAIDA, 'yyyyMMdd') as DT_SAIDA,
        to_date(NASC, 'yyyyMMdd') as NASC,
        *
    except (DT_INTER, DT_SAIDA, NASC, VAL_OBSANG, VAL_PED1AC, CPF_AUT, HOMONIMO)
    from {{ source('dados_bronze', 'raw_datasus_sih') }}
),

deduplicado as (
    select
        *
    from dados_transformados
    qualify row_number() over (partition by N_AIH order by N_AIH) = 1
)

select * from deduplicado