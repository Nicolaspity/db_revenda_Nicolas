# 📊 Banco de Dados - Loja revendedoura de bolsas

---

## 📃 Descrição do Projeto

Este projeto tem como objetivo a modelagem e implementação de um banco de dados para uma loja de bolsas online. Além disso, espera-se que esse projeto agregue conhecimento tanto em aprendizagem teórica (conceitos), tanto em aprendizagem prática (codigos). O sistema fictício inclui:

- Criação do banco de dados
- Definição de tabelas com chaves primárias e estrangeiras
- Definição de tabelas com campos adequados as restrições: campos obrigatórios, campos únicos, campos com valor padrão, campos que satisfazem alguma condição;
- Relacionamentos entre tabelas
- Inserção de pelo menos 10 dados em cada tabela
- Consultas para extração de informações relevantes
- Alterações, modificações e adições conforme solicitado nas aulas
- Adição de índices e especificações like's
- Verifição com explain's e analyze's
- Relacionamentos com os join's
- Diagrama conceitual modelo entidade-relacionamento (ER) no Draw Io

---

## 🔁 Tipos criados

O banco de dados contempla os seguintes tipos:

### status_pedido_enum

### forma_pagamento_enum


### genero_enum

### raca_enum

### metodo_entrega_enum

---

## 🔁 Tabelas

O banco de dados contempla as seguintes tabelas:

### 🧾 usuario

### 🧾 funcionario

### 🛒 pedido

### 🏷️ pedido_produto

### 📦 Produto

### 🗂️ endereco

## 🔗 Relacionamentos

- Um usuario pode fazer **muitos pedidos**
- Um usuario pode incluir **um endereço**
- Um funcionario pode incluir **um enredeço**
- Cada pedido pode conter **vários produtos**
- Cade pedido pode conter **um endereço**

---

## 🔎 Consultas

Algumas consultas desse projeto:

- Listar todas os produtos no sistema
- Listar todas os usuários no sistema
- Listar todas os funcionários no sistema
- Listar todas os pedidos no sistema
- Listar todas os endereços no sistema
- Verificar os pedidos realizados pelos respectivos usuários
- Verificar os pedidos e os produtos contidos nele realizados pelos respectivos usuários
- Relacionar produtos com usuarios
- Relacionar produtos com pedidos
---

graph LR
U[usuário] -->|1:N| P[pedido]
U -->|1:1| E[endereço]
F[funcionário] -->|1:1| E
P -->|N:M| PR[produto]
P -->|1:1| E

## ⚙️ Como Executar

1. Clone o repositório:
    ```bash
    git clone https://github.com/Nicolaspity/db_revenda_Nicolas.git
    ```

2. Importe o script SQL no seu gerenciador de banco de dados (MySQL, PostgreSQL, SQLite, etc.)

3. Rode os scripts de criação e população do banco

4. Execute as consultas desejadas

---

> Projeto acadêmico com fins didáticos: simula um banco de dados completo para uma loja online de bolsas como tarefa de Unidade Currilar **Sistemas de Banco de Dados** do curso Desenvolvimenbto de Sistemas (2023) Senai Petropolis
