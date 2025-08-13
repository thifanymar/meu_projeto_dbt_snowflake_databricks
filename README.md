# Datasus - Pipeline de Dados com Databricks, Snowflake e dbt
## 📌 Contexto
Este projeto foi desenvolvido como parte do Desafio Final de Engenharia de Dados da triggo.ai, com o objetivo de projetar e implementar uma solução de engenharia de dados para a Health Insights Brasil, uma startup fictícia dedicada a tornar os dados de saúde pública do DataSUS mais acessíveis e prontos para análise.

A solução proposta simula um pipeline de dados completo, desde a ingestão dos dados brutos até a modelagem dimensional no formato Star Schema, utilizando **Databricks, Snowflake e dbt**.


## 🛠 Tecnologias Utilizadas
**Databricks** – Ingestão e processamento inicial dos dados (camadas raw e clean).

**Snowflake** – Armazenamento e modelagem dimensional (camada gold).

**dbt** – Transformações, documentação, testes e organização da modelagem.

**Python / PySpark** – Scripts de ingestão e pré-processamento.

**Delta Lake**– Otimização de armazenamento e versionamento no Databricks.

## 📂 Estrutura do Projeto

```bash
bash

'''
.
├── extracao-dados.ipynb              # Notebook que simula extração dos dados DataSUS (camada raw)
├── execucao-projeto-snowflake.ipynb  # Notebook que executa o dbt apontando para o Snowflake
├── dados_datasus.csv                 # Arquivo de dados exemplo (simulação API DataSUS)
├── models/
│   ├── databricks/                   # Modelos dbt da camada clean
│   └── snowflake/                    # Modelos dbt da camada gold (dimensional)
├── dados_simulacao/
│   └── dados_datasus.csv             # Arquivo usado como fonte de dados para o projeto
│   └── simulando-dados.txt           # Arquivo usado para simular a etapa clean no Snowflake
├── profiles.yml                      # Arquivo de configuração dbt (não incluído por segurança)
└── README.md                         # Este documento

```

## 📋 Pré-requisitos
Antes de executar o projeto, você precisa ter:

**1. Conta no Databricks** (workspace ativo).

**2. Conta no Snowflake** com:
    - Warehouse criado (COMPUTE_WH2)

    - Database criado (DW_SAUDE)

    - Schemas:

        - fontes (para dados brutos)

        - gold (para modelo dimensional)

**3. dbt-core** e adaptadores instalados:
```bash
python
pip install dbt-core dbt-snowflake dbt-databricks

```
**4. profiles.yml** configurado para Databricks e Snowflake. Foi incluido nesse repositório um documento de exemplo de como o arquivo deve estar configurado.

**5. Upload** do arquivo dados_datasus.csv no schema fontes do Databricks. O arquivo está localizado na pasta dados_simulacao.

**6. Simular** dados clean no Snowflake. Fois colocado um arquivo para essa simulação na pasta dados_simulacao nomeado como simulando-dados.txt

> Observação:
> A etapa 6 é necessária porque os dados não estão armazenados em um provedor de nuvem compatível com  acesso direto pelo Snowflake.
> Na pasta dados_simulacao está disponível o arquivo usado para extrair os dados do DATASUS, gerar o arquivo CSV e realizar o download.

## 🚀 Como Executar
Para executar temos duas opções. Executar cada um dos notebooks ou criar um job para orquestrar a execução.

### 1. Execução dos notebooks
- No Databricks, abra e execute o notebook extracao-dados.ipynb.
- Abra o notebook execucao-projeto-snowflake.ipynb

### 2. Orquestração
No Databricks vá em **Jobs & Pipelines** e crie um novo job. Esse job deverá ter 2 etapas sendo cada etapa para a execução de um notebook. Preencha as informações da seguinte forma:
- Task Name: crie um nome para a etapa a ser executada
- Type: selecione Notebook
- Source: Workspace
- Path: qual o caminho onde está o repositório do projeto

## 📊 Modelo Dimensional
O modelo segue um **Star Schema** com:
- Dimensões: dim_calendario, dim_hospital, dim_informacoes_hospitalares, dim_paciente
- Fato: fato_sih

Essas tabelas permitem análises de indicadores de saúde pública, como:
- Distribuição de doenças por região.
- Tendências temporais de internações.
- Procedimentos mais realizados por faixa etária e sexo.

Documentação
Documentação disponível via dbt docs generate e dbt docs serve.

## Continuidade para o projeto
- Conectar a pipeline a **uma fonte de dados externa** e armazenar os arquivos brutos em um provedor de nuvem, como **AWS S3**, para garantir escalabilidade e persistência.
- Implementar **carga incremental** para otimizar o processamento e reduzir custos de execução.
- **Adicionar novas fontes de dados**, ampliando o escopo de análise e permitindo cruzamentos com diferentes conjuntos do DataSUS ou outras bases públicas.

## Dashboard desenvolvido
Link:
https://app.powerbi.com/view?r=eyJrIjoiYTEyYmRmODAtZmJjNi00MzM1LTlmMWMtNjg5YWVmYzg1Yjk1IiwidCI6IjQ5Njk0NmExLWE2YzktNDQxOS1iZWZlLTk4OTBkMzgwNjdkNCJ9

## 📜 Desenvolvimento
Projeto desenvolvido para fins educacionais no Desafio Final do Bootcamp de Engenharia de Dados da triggo.ai.