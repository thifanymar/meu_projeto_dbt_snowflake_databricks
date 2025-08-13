{{ config(materialized='table',alias='fato_sih',schema='datasus') }}

with base as (
    select * from {{ source('base_limpa', 'CLEAN_DADOS') }}
),

dim_informacoes as (
    select
        sk_informacoes_hospitalares,
        MARCA_UTI,
        ESPEC,
        IDENT,
        COBRANCA,
        CAR_INT,
        NATUREZA
    from gold_datasus.dim_informacoes_hospitalares
),

dim_paciente as (
    select
        sk_paciente,
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
    from gold_datasus.dim_paciente
),

dim_hospital as (
    select
        sk_hospital,
        UF_ZI,
        CGC_HOSP,
        GESTAO,
        MUNIC_MOV
    from gold_datasus.dim_hospital
)

select
    info.sk_informacoes_hospitalares,
    hosp.sk_hospital,
    pac.sk_paciente,

    -- mantém as colunas de data originais, sem substituir por SK
    base.DT_INTER,
    base.DT_SAIDA,

    -- outras colunas do fato
    base.UF_ZI,
    base.CGC_HOSP,
    base.GESTAO,
    base.MUNIC_MOV,
    base.ANO_CMPT,
    base.MES_CMPT,

    base.N_AIH,
    base.UTI_MES_IN,
    base.UTI_MES_AN,
    base.UTI_MES_AL,
    base.UTI_MES_TO,
    base.UTI_INT_IN,
    base.UTI_INT_AN,
    base.UTI_INT_AL,
    base.UTI_INT_TO,
    base.VAL_SH,
    base.VAL_SP,
    base.VAL_SADT,
    base.VAL_RN,
    base.VAL_ORTP,
    base.VAL_SANGUE,
    base.VAL_SADTSR,
    base.VAL_TRANSP,
    base.VAL_TOT,
    base.VAL_UTI,
    base.US_TOT,
    base.TOT_PT_SP,
    base.DIAS_PERM,
    base.COD_ARQ,
    base.CONT,
    base.NUM_PROC,
    base.DIAG_PRINC,
    base.DIAG_SECUN,
    base.PROC_REA,
    base.CID_NOTIF,
    base.CONTRACEP1,
    base.CONTRACEP2,
    base.GESTRISCO

from base

left join dim_informacoes info on
    base.MARCA_UTI = info.MARCA_UTI and
    base.ESPEC = info.ESPEC and
    base.IDENT = info.IDENT and
    base.COBRANCA = info.COBRANCA and
    base.CAR_INT = info.CAR_INT and
    base.NATUREZA = info.NATUREZA

left join dim_hospital hosp on
    base.UF_ZI = hosp.UF_ZI and
    base.CGC_HOSP = hosp.CGC_HOSP and
    base.GESTAO = hosp.GESTAO and
    base.MUNIC_MOV = hosp.MUNIC_MOV

left join dim_paciente pac on
    base.CEP = pac.CEP and
    base.MUNIC_RES = pac.MUNIC_RES and
    base.NASC = pac.NASC and
    base.SEXO = pac.SEXO and
    base.COD_IDADE = pac.COD_IDADE and
    base.IDADE = pac.IDADE and
    base.NACIONAL = pac.NACIONAL and
    base.NUM_FILHOS = pac.NUM_FILHOS and
    base.INSTRU = pac.INSTRU and
    base.MORTE = pac.MORTE
