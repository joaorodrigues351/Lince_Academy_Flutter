# IA como apoio - Flutter: Programação assíncrona

Aluno: João Eduardo Pereira Rodrigues
Disciplina: Lince Tech Academy

---

## Pergunta 1

### Prompt utilizado
O que é programação assíncrona em Flutter e por que ela é importante?

### Resposta resumida
É a forma de executar tarefas que demoram (como buscar dados na internet) sem travar o resto do app. Enquanto a tarefa não termina, o aplicativo continua respondendo normalmente ao usuário.

### Observações
Sem ela, a tela congelaria durante operações demoradas.

---

## Pergunta 2

### Prompt utilizado
Quais cuidados devo ter usando programação assíncrona?

### Resposta resumida
Sempre tratar erros (try-catch), evitar deixar o usuário sem feedback durante a espera, não esquecer o `await` quando necessário e cuidar para não atualizar a tela depois que o widget já foi removido.

### Observações
Esquecer o await é um erro comum que gera bugs silenciosos.

---

## Pergunta 3

### Prompt utilizado
O que são isolates em Flutter?

### Resposta resumida
Isolates são "linhas de execução" independentes que rodam em paralelo, cada uma com sua própria memória. Servem para tarefas muito pesadas, que rodam separadas sem travar a interface principal.

### Observações
Diferente de async comum, o isolate roda de verdade em paralelo.

---

## Pergunta 4

### Prompt utilizado
Quais cuidados devo ter ao usar isolates em Flutter?

### Resposta resumida
Isolates não compartilham memória, então a comunicação é feita por troca de mensagens, o que é mais complexo. Devem ser usados só quando realmente necessário (tarefas pesadas), pois têm custo de criação.

### Observações
Só vale a pena para processamento pesado de verdade.

---

## Pergunta 5

### Prompt utilizado
Qual o conceito do Loop de Eventos em Flutter?

### Resposta resumida
O Event Loop é o mecanismo que gerencia a fila de tarefas do app, executando uma de cada vez. Ele decide a ordem em que operações assíncronas (como Futures) são processadas, mantendo a interface fluida.

### Observações
É o "organizador de fila" das tarefas do app.

---

## Pergunta 6

### Prompt utilizado
O que é um 'Future' em Dart e como ele funciona?

### Resposta resumida
Um Future é a promessa de um valor que ainda vai chegar, resultado de uma operação que leva tempo. Ele pode estar pendente (esperando) ou completo (com sucesso ou com erro).

### Observações
É como um "vale" que será trocado pelo valor real depois.

---

## Pergunta 7

### Prompt utilizado
Como posso usar 'async' e 'await' para trabalhar com 'Futures'?

### Resposta resumida
Marca-se a função com `async` e usa-se `await` antes da operação demorada, o que faz o código esperar o resultado sem travar o app, escrevendo de forma parecida com código normal (linha após linha).

### Observações
O await deixa o código assíncrono mais legível.

---

## Pergunta 8

### Prompt utilizado
Como posso lidar com erros em operações assíncronas usando 'try-catch'?

### Resposta resumida
Envolvendo o código com `await` dentro de um bloco `try`, e capturando falhas no `catch`. Assim, se a requisição falhar, o app trata o erro em vez de quebrar.

### Observações
O try-catch evita que um erro derrube o app.

---

## Pergunta 9

### Prompt utilizado
Traga a explicação dos métodos HTTP.

### Resposta resumida
Os principais são: `GET` (buscar dados), `POST` (enviar/criar dados), `PUT` (atualizar dados), `DELETE` (remover dados) e `PATCH` (atualizar parcialmente). Cada um representa uma intenção diferente ao se comunicar com um servidor.

### Observações
GET é para ler; POST para criar; PUT/PATCH para editar; DELETE para apagar.

---

## Pergunta 10

### Prompt utilizado
Como posso lidar com diferentes códigos de resposta HTTP (200, 404, 500)?

### Resposta resumida
Verificando o `statusCode` da resposta: 200 significa sucesso, 404 que não foi encontrado e 500 erro no servidor. Com base nesse código, o app decide exibir os dados ou uma mensagem de erro.

### Observações
Sempre conferir o statusCode antes de usar os dados.

---

## Pergunta 11

### Prompt utilizado
O que é JSON e como ele é usado em Flutter?

### Resposta resumida
JSON é um formato de texto para trocar dados, organizado em pares chave-valor. É o formato mais comum retornado por APIs, e o Flutter converte esse texto em estruturas Dart (Map e List) para usar no app.

### Observações
É o "idioma" padrão de comunicação com APIs.

---

## Pergunta 12

### Prompt utilizado
Como posso acessar valores específicos em um objeto JSON?

### Resposta resumida
Depois de decodificado, o JSON vira um Map, e acessa-se cada valor pela chave, como `dados['nome']`.

### Observações
Acessa-se pelo nome da chave, entre colchetes.

---

## Pergunta 13

### Prompt utilizado
Como posso lidar com arrays (listas) em JSON em Flutter?

### Resposta resumida
Arrays no JSON viram `List` no Dart. Dá para acessar itens pelo índice (ex: `lista[0]`) ou percorrer todos com um laço, tratando cada elemento (que costuma ser um Map).

### Observações
Array no JSON = List no Dart.

---

## Pergunta 14

### Prompt utilizado
Como posso iterar sobre os elementos de um array JSON?

### Resposta resumida
Usando laços como `for` ou o método `map`, percorrendo a lista e transformando cada item (por exemplo, convertendo cada Map em um objeto de uma classe Dart).

### Observações
O map é muito usado para converter a lista em objetos.

---

## Pergunta 15

### Prompt utilizado
Por que é útil mapear JSON para classes Dart?

### Resposta resumida
Porque trabalhar com objetos de classes é mais seguro e organizado do que acessar Maps por chave (que é propenso a erros de digitação). Com classes, o código fica mais legível e o editor ajuda com autocompletar.

### Observações
Classes evitam erros de digitar a chave errada.

---

## Pergunta 16

### Prompt utilizado
Como posso usar 'factory' para criar objetos Dart a partir de JSON?

### Resposta resumida
Cria-se um construtor `factory NomeClasse.fromJson(Map json)` que recebe o Map e retorna um objeto da classe, pegando cada valor do JSON pela chave e atribuindo aos campos.

### Observações
O fromJson é o padrão para transformar JSON em objeto.

---

## Pergunta 17

### Prompt utilizado
Como posso usar 'toJson()' para converter objetos Dart em JSON?

### Resposta resumida
Cria-se um método `toJson()` na classe que retorna um Map com os dados do objeto. Serve para o caminho inverso: transformar o objeto Dart de volta em JSON, geralmente para enviar ao servidor.

### Observações
fromJson lê o JSON; toJson escreve o JSON.

---

## Pergunta 18

### Prompt utilizado
Como organizar minhas requisições no meu código Flutter? Quais as boas práticas realizando requisições?

### Resposta resumida
Separar as requisições da interface, criando classes de "serviço" ou "repositório" só para isso. Reaproveitar código, tratar erros em um lugar central e não misturar chamadas de API dentro dos widgets são boas práticas.

### Observações
O ideal é não fazer requisição direto dentro da tela.

---

## Pergunta 19

### Prompt utilizado
Como posso exibir uma mensagem de carregamento enquanto a requisição HTTP está em andamento?

### Resposta resumida
O exemplo mostrado usava um `FutureBuilder` ou uma variável de estado de "carregando", exibindo um `CircularProgressIndicator` enquanto o Future não terminava e trocando pelos dados quando a resposta chegava.

### Observações
Entendi o conceito do indicador de carregamento e vou aplicar do meu jeito.

---

## Pergunta 20

### Prompt utilizado
De exemplos de consumo a APIs em Flutter?

### Resposta resumida
O exemplo usava o pacote `http` para fazer um GET em uma API pública, decodificava o JSON da resposta, convertia em objetos com fromJson e exibia numa lista com ListView. Tudo dentro de uma função async com try-catch.

### Observações
Entendi o fluxo completo (requisição → JSON → objeto → tela) e vou montar o meu.

---

## Conclusão
Nesta atividade aprendi os fundamentos da programação assíncrona no Flutter, entendendo Futures, async/await e como o Event Loop e os isolates gerenciam tarefas sem travar o app. Vi como fazer requisições com o pacote http, tratar erros com try-catch e lidar com os códigos de resposta HTTP. Também aprendi a trabalhar com JSON, acessando valores, percorrendo arrays e convertendo dados em classes Dart com fromJson e toJson. Por fim, entendi boas práticas de organização das requisições e como exibir um indicador de carregamento durante a espera.
