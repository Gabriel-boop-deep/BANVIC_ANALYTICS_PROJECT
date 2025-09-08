# 🚀 BanVic Analytics Challenge — Indicium 2025  
**Autor:** Gabriel [Seu Sobrenome]  
**Projeto:** BANVIC_ANALYTICS_PROJECT  
**Ferramentas:** dbt, BigQuery, SQL, YAML, Git

---

## 📌 Sobre o Desafio

Este projeto foi desenvolvido como parte do processo seletivo da Indicium, simulando uma situação real de uma instituição financeira fictícia — o BanVic — que busca amadurecer sua cultura de dados. O objetivo foi construir uma solução analítica robusta, capaz de gerar insights estratégicos e apoiar decisões de negócio orientadas por dados.

---

## 🎯 Objetivos do Projeto

- Estruturar um modelo dimensional completo com staging, dimensões e tabela fato.
- Enriquecer os dados com múltiplas fontes e aplicar boas práticas de modelagem analítica.
- Gerar indicadores que apoiem a CEO Sofia Oliveira e ajudem a convencer a Diretora Comercial Camila Diniz sobre o valor da inteligência analítica.
- Demonstrar domínio técnico com dbt e clareza na documentação e organização do projeto.

---

## 🧠 Estratégia de Modelagem

O projeto foi estruturado em três camadas principais:

### 1. **Staging Layer**
Transformações iniciais dos dados brutos, com padronização de nomes, tipos e formatos.  
Modelos: `stg_bap_clientes`, `stg_bap_agencias`, `stg_bap_colaborador`, `stg_bap_contas`, `stg_bap_transacoes`, `stg_bap_propostas_credito`.

### 2. **Dimensões**
Modelos dimensionais com chaves substitutas (`*_sk`) e documentação em YAML.  
Modelos: `dim_bap_cliente`, `dim_bap_agencia`, `dim_bap_colaborador`, `dim_dates`.

### 3. **Fato**
Modelo `fact_bap_transacoes` consolidando métricas financeiras e relacionando todas as dimensões relevantes.  
Inclui cálculo de custo financeiro estimado com base na taxa de juros mensal.

---

## 📊 Indicadores Gerados

- Volume e valor de transações por cliente, agência e colaborador.
- Estimativa de custo financeiro por transação.
- Integração com propostas de crédito e dados de contas.
- Segmentação temporal via `dim_dates`.

---

## 🛠️ Boas Práticas Aplicadas

- Uso de `dbt_utils.generate_surrogate_key` para garantir unicidade e rastreabilidade.
- Separação clara entre camadas de transformação e modelagem.
- Documentação completa via arquivos `.yml`, com testes de unicidade e não nulos.
- Nomenclatura padronizada e legibilidade de código.
- Joins eficientes e tipagem consistente para evitar erros de compilação.

---

## 📈 Próximos Passos

- Implementar testes adicionais com `dbt tests` para validação de regras de negócio.
- Criar snapshots para acompanhar evolução de clientes e propostas.
- Desenvolver dashboards interativos com Metabase ou Power BI.
- Enriquecer o modelo com dados externos (IBGE, SELIC, câmbio) para análises macroeconômicas.

---

## 🙋 Sobre Mim

Sou apaixonado por transformar dados em decisões. Neste projeto, busquei ir além da técnica — construindo uma solução que conversa com o negócio, respeita a governança e entrega valor real. Acredito que dados bem tratados são o motor da inovação, e estou pronto para contribuir com essa visão na Indicium.

---

> _“Dados não são apenas números. São histórias esperando para serem contadas.”_
