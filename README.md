# 🚀 BanVic Analytics Challenge — Indicium 2025  

**👤 Autor:** Gabriel Nunes Barbosa Nogueira  
**📂 Projeto:** `BANVIC_ANALYTICS_PROJECT`  
**🛠️ Ferramentas:** dbt | BigQuery | SQL | YAML | Git  

---

## 📌 Sobre o Desafio  

Este projeto foi desenvolvido como parte do **processo seletivo da Indicium**, simulando uma situação real de uma instituição financeira fictícia — o **BanVic**.  
O desafio consistiu em **construir uma solução analítica robusta**, capaz de gerar **insights estratégicos** e apoiar decisões de negócio orientadas por dados.  

---

## 🎯 Objetivos  

- 📊 Estruturar um **modelo dimensional completo** (staging, dimensões e fato).  
- 🔗 Enriquecer os dados com múltiplas fontes, aplicando boas práticas de modelagem.  
- 💡 Criar indicadores que apoiem a **CEO Sofia Oliveira** e ajudem a convencer a **Diretora Comercial Camila Diniz** sobre o valor da inteligência analítica.  
- 🧩 Demonstrar **domínio técnico com dbt** e **clareza na documentação**.  

---

## 🧠 Estratégia de Modelagem  

O projeto foi organizado em **três camadas principais**:  

### 1️⃣ Staging Layer  
Transformações iniciais dos dados brutos, com padronização de nomes, tipos e formatos.  
📌 Modelos:  
`stg_bap_clientes`, `stg_bap_agencias`, `stg_bap_colaborador`, `stg_bap_contas`, `stg_bap_transacoes`, `stg_bap_propostas_credito`  

### 2️⃣ Dimensões  
Modelos dimensionais com chaves substitutas (`*_sk`) e documentação em YAML.  
📌 Modelos:  
`dim_bap_cliente`, `dim_bap_agencia`, `dim_bap_colaborador`, `dim_dates`  

### 3️⃣ Fato  
Modelo `fact_bap_transacoes` consolidando métricas financeiras e relacionando todas as dimensões relevantes.  
Inclui cálculo de **custo financeiro estimado** com base na taxa de juros mensal.  

---

## 📊 Indicadores Criados  

- 💳 Volume e valor de transações por **cliente, agência e colaborador**.  
- 💰 Estimativa de **custo financeiro por transação**.  
- 🔗 Integração com **propostas de crédito e dados de contas**.  
- 📆 Segmentação temporal via `dim_dates`.  

---

## 🛠️ Boas Práticas  

✔️ Uso de `dbt_utils.generate_surrogate_key` para garantir unicidade e rastreabilidade.  
✔️ Separação clara entre **camadas de transformação e modelagem**.  
✔️ Documentação completa via `.yml` com **testes de unicidade e não nulos**.  
✔️ **Nomenclatura padronizada** e legibilidade do código.  
✔️ **Joins eficientes** e tipagem consistente para evitar erros.  

---

## 🚀 Próximos Passos  

- 🧪 Implementar **testes adicionais** (`dbt tests`) para regras de negócio.  
- 🕒 Criar **snapshots** para acompanhar evolução de clientes e propostas.  
- 📊 Desenvolver **dashboards interativos** (Metabase / Power BI).  
- 🌎 Enriquecer o modelo com **dados externos** (IBGE, SELIC, câmbio) para análises macroeconômicas.  

---

## 🙋 Sobre Mim  

Sou apaixonado por **transformar dados em decisões**.  
Neste projeto, busquei ir além da técnica: **construí uma solução que conversa com o negócio**, respeita a governança e entrega valor real.  

> _“Dados não são apenas números. São histórias esperando para serem contadas.”_  
