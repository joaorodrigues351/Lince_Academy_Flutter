# IA como apoio - Flutter: Persistência de dados

Aluno: João Eduardo Pereira Rodrigues
Disciplina: Lince Tech Academy

---

## Pergunta 1

### Prompt utilizado
O que é persistência de dados em aplicativos Flutter e por que é importante?

### Resposta resumida
Persistência de dados é a capacidade de guardar informações no dispositivo para que elas continuem disponíveis mesmo depois de fechar o app. É importante porque mantém dados como preferências, login e conteúdo salvos entre uma sessão e outra.

### Observações
Sem persistência, tudo seria perdido ao fechar o app.

---

## Pergunta 2

### Prompt utilizado
Quais são os diferentes tipos de dados que podem ser persistidos em um aplicativo Flutter?

### Resposta resumida
Podem ser persistidos dados simples (chave-valor, com SharedPreferences), dados estruturados em banco local (SQLite, drift, hive), arquivos (imagens, textos, JSON) e dados na nuvem (Firebase, APIs).

### Observações
Cada tipo de dado pede uma forma diferente de armazenar.

---

## Pergunta 3

### Prompt utilizado
O que é o pacote SharedPreferences em Flutter e como ele funciona?

### Resposta resumida
É um pacote que salva dados simples em formato chave-valor no próprio dispositivo. Funciona guardando valores pequenos (como String, int, bool) que ficam disponíveis mesmo após fechar o app.

### Observações
É ideal para guardar pequenas configurações.

---

## Pergunta 4

### Prompt utilizado
Quais são as limitações do SharedPreferences em termos de armazenamento de dados?

### Resposta resumida
Só guarda tipos simples (String, int, double, bool e listas de String), não serve para grandes volumes nem dados complexos/relacionais, e não é indicado para informações sensíveis, pois não é criptografado.

### Observações
Não serve para muitos dados ou dados estruturados.

---

## Pergunta 5

### Prompt utilizado
Quando devo usar SharedPreferences em vez de outras opções de persistência de dados?

### Resposta resumida
Quando os dados são pequenos e simples, como preferências do usuário, tema escolhido, se já viu o tutorial, ou um token de login. Para dados grandes ou estruturados, o ideal é um banco de dados local.

### Observações
Pequeno e simples = SharedPreferences; complexo = banco de dados.

---

## Pergunta 6

### Prompt utilizado
Como posso lidar com erros ao usar SharedPreferences?

### Resposta resumida
Usando try-catch nas operações de leitura e escrita e tratando o caso de a chave não existir (retornando um valor padrão). Assim o app não quebra se o dado ainda não foi salvo.

### Observações
Sempre prever quando a chave ainda não existe.

---

## Pergunta 7

### Prompt utilizado
Quais são as melhores práticas para usar SharedPreferences de forma eficiente?

### Resposta resumida
Guardar os nomes das chaves em constantes (evitando erro de digitação), não salvar grandes volumes, centralizar o acesso numa classe de serviço e sempre tratar valores nulos com padrões.

### Observações
Usar constantes para as chaves evita erros e facilita a manutenção.

---

## Pergunta 8

### Prompt utilizado
Crie um app que permita ao usuário salvar seu nome e sobrenome usando SharedPreferences e exibi-los na tela.

### Resposta resumida
O exemplo mostrado tinha dois TextFields (nome e sobrenome) e um botão que salvava os valores no SharedPreferences com `setString`. Ao abrir o app, ele lia esses valores com `getString` e exibia na tela, mantendo os dados mesmo após fechar.

### Observações
Entendi o fluxo de salvar e ler com setString/getString e vou montar do meu jeito.

---

## Pergunta 9

### Prompt utilizado
Crie um app de lista de tarefas que salve as tarefas em SharedPreferences e as exiba na tela, mantendo as tarefas mesmo após o aplicativo ser fechado.

### Resposta resumida
O exemplo guardava a lista de tarefas como uma lista de String no SharedPreferences (`setStringList`). Ao adicionar ou remover uma tarefa, a lista era atualizada e salva de novo; ao abrir o app, ela era carregada com `getStringList` e exibida num ListView.

### Observações
Entendi como usar setStringList/getStringList para listas e vou implementar a minha.

---

## Conclusão
Nesta atividade aprendi o conceito de persistência de dados no Flutter e por que ela é essencial para manter informações mesmo após o app ser fechado. Entendi os diferentes tipos de armazenamento e, em especial, como o SharedPreferences funciona para guardar dados simples em formato chave-valor, além de suas limitações e quando usá-lo em vez de um banco de dados. Também vi como tratar erros e valores nulos, boas práticas como usar constantes para as chaves, e na prática como salvar e ler tanto valores simples (setString/getString) quanto listas (setStringList/getStringList).
