
> *Project status:* completed

> *:busts_in_silhouette: Author:* Mário Augusto Carvalho Lara Leite


> *:email: Email:* tkyakow@gmail.com

> :date: *Year:* 2024

# Case:

Olá, você acaba de ser contratado como desenvolvedor em uma grande empresa e começa a receber seus primeiros projetos para trabalhar. Sua empresa não usa o ARTIA como solução para acompanhamento de projetos e tarefas então como você precisa ter uma visibilidade melhor das suas atividades resolve desenvolver uma solução para acompanhar suas entregas.

Você precisa criar um cadastro de projetos com a data de início e data final para a entrega, esse projeto pode ter 1 ou N atividades que também precisam ser cadastradas com as datas de início e data de fim. Após ter feito todos os cadastros precisamos saber quantos % dos projetos já temos finalizados e também se o projeto terá atrasos ou não. Para saber a % de andamento do projeto deve ser considerado o número de atividades finalizadas e quantidade de atividades ainda sem finalizar. Para saber se o projeto terá atraso considere a maior data final das atividades e compare com a data final do projeto, se for maior que a data final, o projeto terminará com atrasos. Abaixo segue exemplo das tabelas para cadastros.

Maiores informações: https://github.com/Artia/desafios-desevolvimento/blob/master/desafio-fullstack.md

**Summary:**

O projeto foi desenvolvido seguindo as melhores práticas de criação de APIs REST no Ruby on Rails, com uma arquitetura bem definida que prioriza a separação de dependências e responsabilidades. A qualidade do código foi garantida de testes utilizando RSpec, integrando-o com o Swagger para assegurar consistência e a clareza na documentação.

Os testes incluíram:

 - Testes de Integração: Para verificar o funcionamento entre diferentes partes do sistema.
  - Testes de Funcionalidade dos Modelos: Garantindo a integridade e o comportamento esperado das validações e métodos.
  - Testes de Serializers: Certificando-se de que os dados expostos pelos endpoints estão formatados corretamente.
  - Testes de Métodos Específicos: Validando a lógica de negócios em  unidades específicas.

A documentação dos endpoints foi implementada utilizando o Swagger, facilitando visualmente o uso da API por outros desenvolvedores.

# Versions:

> ruby 3.3.4 (2024-07-09 revision be1089c8ec) [x86_64-linux]

> Rails 7.1.4

# Start Rails

> rake db:create db:migrate db:seed

> please use the port 3001, so execute: rails s -p 3001

# Tests

> Run in terminal: rspec spec

# Swagger

> http://localhost:3001/api-docs

# RuboCop

![RUBOCOP!](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvMSFQaCKg10EWCRxKz6sQWiTpHbiMdqjbGA&usqp=CAU)

> Following Rubocop patterns

**Thank you!**