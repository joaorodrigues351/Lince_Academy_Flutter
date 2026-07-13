# IA como apoio - Flutter: Gerenciamento de estados

Aluno: João Eduardo Pereira Rodrigues
Disciplina: Lince Tech Academy

---

## Pergunta 1

### Prompt utilizado
O que é gerenciamento de estados em Flutter e por que é importante?

### Resposta resumida
Gerenciamento de estado é a forma de controlar e atualizar os dados que mudam no app (o "estado") e refletir essas mudanças na tela. É importante porque mantém a interface sempre sincronizada com os dados, de forma organizada.

### Observações
Estado é tudo que pode mudar e afetar o que aparece na tela.

---

## Pergunta 2

### Prompt utilizado
Qual a diferença entre estado local e estado global em um aplicativo Flutter?

### Resposta resumida
Estado local pertence a um único widget e só é usado ali (ex: setState). Estado global é compartilhado entre várias telas/widgets do app, sendo acessível de vários lugares.

### Observações
Local fica numa tela só; global é compartilhado pelo app.

---

## Pergunta 3

### Prompt utilizado
Quais as vantagens de usar um gerenciador de estados em um projeto Flutter?

### Resposta resumida
Organiza melhor o código, evita passar dados manualmente de widget em widget, facilita compartilhar estado entre telas e reduz reconstruções desnecessárias, deixando o app mais escalável.

### Observações
Ajuda principalmente quando o app cresce.

---

## Pergunta 4

### Prompt utilizado
O que é o pacote Provider em Flutter e para que ele serve?

### Resposta resumida
O Provider é um pacote popular de gerenciamento de estado que disponibiliza dados para a árvore de widgets de forma simples, permitindo que widgets descendentes acessem e reajam a esse estado.

### Observações
É uma das formas mais usadas de gerenciar estado no Flutter.

---

## Pergunta 5

### Prompt utilizado
Como o Provider ajuda a evitar a reconstrução desnecessária de widgets?

### Resposta resumida
Ele permite que apenas os widgets que realmente dependem do estado sejam reconstruídos quando ele muda, em vez de reconstruir a tela inteira. Isso é feito com ferramentas como o Consumer e o Selector.

### Observações
Só reconstrói o que precisa, melhorando a performance.

---

## Pergunta 6

### Prompt utilizado
Como o Provider simplifica o gerenciamento de estados em Flutter?

### Resposta resumida
Ele centraliza o estado num único lugar e o disponibiliza para quem precisar, evitando o "empilhamento" de dados passados manualmente por vários widgets (prop drilling).

### Observações
Evita ter que passar dados de widget em widget na mão.

---

## Pergunta 7

### Prompt utilizado
O que é o ChangeNotifierProvider e como ele funciona?

### Resposta resumida
É um tipo de provider que fornece uma classe baseada em `ChangeNotifier` para a árvore de widgets. Quando essa classe chama `notifyListeners()`, os widgets que a escutam são avisados e reconstruídos.

### Observações
Ele "avisa" os widgets sempre que o estado muda.

---

## Pergunta 8

### Prompt utilizado
Como posso fornecer um ChangeNotifier para a árvore de widgets usando ChangeNotifierProvider?

### Resposta resumida
Envolvendo a parte do app que vai usar o estado com o `ChangeNotifierProvider`, geralmente no topo da árvore, e passando a classe ChangeNotifier no parâmetro `create`.

### Observações
Costuma-se colocar bem no topo, envolvendo o app.

---

## Pergunta 9

### Prompt utilizado
Como posso atualizar o estado do meu aplicativo usando providers?

### Resposta resumida
Alterando os dados dentro da classe ChangeNotifier e chamando `notifyListeners()`, que dispara a atualização dos widgets que dependem daquele estado.

### Observações
Sem o notifyListeners(), a tela não atualiza.

---

## Pergunta 10

### Prompt utilizado
O que é o Consumer e como ele funciona?

### Resposta resumida
O Consumer é um widget que "escuta" um provider e reconstrói apenas a parte dentro dele quando o estado muda, fornecendo o valor atual através de um builder.

### Observações
Ele isola a parte da tela que precisa reagir ao estado.

---

## Pergunta 11

### Prompt utilizado
Como o Consumer ajuda a reconstruir apenas os widgets que dependem do estado?

### Resposta resumida
Colocando só a parte que depende do estado dentro do Consumer, apenas ela é reconstruída quando o estado muda — o resto da tela fica intacto, economizando processamento.

### Observações
Quanto menor o trecho dentro do Consumer, melhor a performance.

---

## Pergunta 12

### Prompt utilizado
Como posso usar o Consumer para acessar o estado fornecido pelo ChangeNotifierProvider?

### Resposta resumida
Usando `Consumer<MinhaClasse>(builder: (context, valor, child) { ... })`, onde `valor` é a instância do estado, permitindo ler seus dados e chamar seus métodos.

### Observações
O builder entrega o estado pronto para usar.

---

## Pergunta 13

### Prompt utilizado
Qual a diferença entre usar Consumer e Provider.of() para acessar o estado?

### Resposta resumida
O `Consumer` reconstrói só o trecho dentro dele quando o estado muda. Já o `Provider.of()` com `listen: true` reconstrói o widget inteiro onde foi chamado. Para só executar uma ação sem reconstruir, usa-se `Provider.of(context, listen: false)`.

### Observações
Consumer é mais preciso; Provider.of reconstrói mais coisa.

---

## Pergunta 14

### Prompt utilizado
Como posso otimizar o uso do Consumer para evitar reconstruções desnecessárias?

### Resposta resumida
Colocando o Consumer só ao redor do que realmente muda, usando o parâmetro `child` para as partes que não mudam (elas não são reconstruídas) e, quando preciso, usando o `Selector` para escutar apenas um valor específico.

### Observações
O parâmetro child guarda o que não precisa reconstruir.

---

## Pergunta 15

### Prompt utilizado
Crie um aplicativo simples com um contador que pode ser incrementado e decrementado, usando ChangeNotifierProvider e Consumer.

### Resposta resumida
O exemplo mostrado tinha uma classe ChangeNotifier com uma variável de contagem e métodos de incrementar/decrementar (chamando notifyListeners). O ChangeNotifierProvider ficava no topo e um Consumer exibia o número, com botões acionando os métodos.

### Observações
Entendi o fluxo completo e vou montar o contador do meu jeito.

---

## Pergunta 16

### Prompt utilizado
Crie um aplicativo de tema que permite ao usuário alternar entre temas claros e escuros, usando ChangeNotifierProvider e Consumer.

### Resposta resumida
O exemplo usava uma classe ChangeNotifier guardando o tema atual (claro/escuro) com um método para alternar. O ChangeNotifierProvider ficava no topo e o MaterialApp lia o tema pelo Consumer, trocando entre ThemeData claro e escuro.

### Observações
Entendi como o tema pode ser um estado global e vou implementar o meu.

---

## Conclusão
Nesta atividade aprendi o que é gerenciamento de estado no Flutter e a diferença entre estado local e global. Entendi como o pacote Provider simplifica o compartilhamento de dados pela árvore de widgets e evita reconstruções desnecessárias. Vi como o ChangeNotifierProvider fornece um estado baseado em ChangeNotifier e como o notifyListeners() dispara as atualizações. Também compreendi o papel do Consumer em reconstruir apenas as partes que dependem do estado, a diferença dele para o Provider.of() e formas de otimizar o desempenho usando o parâmetro child e o Selector.
