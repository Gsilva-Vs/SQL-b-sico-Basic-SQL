<h1 align="center"> Basic SQL – Banco de Dados </h1>
<h3 align="center">Exemplos práticos de SQL com MySQL/MariaDB | Ideal para iniciantes</h3>


---

###  Sobre o projeto

Este repositório contém um script SQL completo para criar e manipular um banco de dados simples de uma escola. Foi desenvolvido para quem está começando no mundo de bancos de dados relacionais e deseja praticar comandos essenciais do SQL.

O arquivo `Gustavo_Silva_SQL.sql` cria o banco `curso`, com as tabelas `aluno`, `sala` e `curso`, além de chaves primárias, estrangeiras, dados de exemplo e **quatro visões (views)** que facilitam consultas comuns.

---

###  Estrutura do banco de dados

- **aluno** – armazena dados pessoais (nome, CPF, email, telefone, endereço) e uma referência para a sala.
- **sala** – contém o nome da sala e o curso ao qual ela pertence.
- **curso** – guarda o nome do curso e sua carga horária.

**Relacionamentos:**  
Uma sala pertence a um curso (chave estrangeira `id_curso`). Um aluno está alocado em uma sala (chave estrangeira `id_sala`).

---

###  Views disponíveis

| View | Descrição |
|------|-----------|
| `vw_aluno_sala` | Nome do aluno e nome da sala |
| `vw_aluno_curso` | Nome do aluno e nome do curso |
| `vw_aluno_sala_curso` | Junção completa: aluno + sala + curso |
| `vw_aluno_anonimizado` | CPF e email com dados parciais ocultos (funções `CONCAT`, `LEFT`, `SUBSTRING_INDEX`) |

---
