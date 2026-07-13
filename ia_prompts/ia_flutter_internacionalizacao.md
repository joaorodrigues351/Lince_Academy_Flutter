# IA como apoio - Flutter: Internacionalização

Aluno: João Eduardo Pereira Rodrigues
Disciplina: Lince Tech Academy

---

## Pergunta 1

### Prompt utilizado
O que é internacionalização e qual sua importância?

### Resposta resumida
Internacionalização (i18n) é o processo de preparar um app para funcionar em vários idiomas e regiões, adaptando textos, datas, moedas e formatos. É importante porque permite que o aplicativo alcance usuários de diferentes países, tornando-o acessível a um público maior.

### Observações
i18n deixa o app pronto para ser traduzido e usado no mundo todo.

---

## Pergunta 2

### Prompt utilizado
Como funciona a internacionalização no Flutter?

### Resposta resumida
O Flutter usa o pacote `intl` junto com arquivos de tradução (ARB), um para cada idioma. Os textos ficam separados do código, e o app escolhe o idioma certo com base na configuração do dispositivo (locale).

### Observações
Os textos ficam fora do código, em arquivos de idioma separados.

---

## Pergunta 3

### Prompt utilizado
Quais as dicas de uso dos arquivos ARB?

### Resposta resumida
Manter um arquivo ARB por idioma (ex: app_en.arb, app_pt.arb), usar as mesmas chaves em todos eles, dar nomes claros às chaves e aproveitar os placeholders para valores dinâmicos (como nome ou quantidade dentro da frase).

### Observações
As chaves precisam ser iguais em todos os arquivos de idioma.

---

## Pergunta 4

### Prompt utilizado
Quais cuidados devo ter ao usar o INTL?

### Resposta resumida
Não deixar textos fixos ("hardcoded") no código, manter as traduções sincronizadas entre os idiomas, testar o app em cada locale e lembrar de gerar os arquivos de tradução após alterações nos ARB.

### Observações
O maior cuidado é não esquecer textos escritos direto no código.

---

## Pergunta 5

### Prompt utilizado
Como posso adicionar suporte para diferentes idiomas em meu aplicativo Flutter?

### Resposta resumida
Adicionando os pacotes `flutter_localizations` e `intl`, criando os arquivos ARB de cada idioma, configurando os `localizationsDelegates` e `supportedLocales` no MaterialApp, e acessando os textos traduzidos pelas chaves geradas.

### Observações
A configuração principal fica no MaterialApp (delegates e locales).

---

## Pergunta 6

### Prompt utilizado
Mostre o exemplo de um formulário de cadastro usando internacionalização.

### Resposta resumida
O exemplo mostrado tinha um formulário com campos (nome, e-mail, senha) onde todos os textos — labels, botões e mensagens de erro — vinham das chaves de tradução em vez de textos fixos. Ao trocar o idioma do dispositivo, o formulário inteiro aparecia no idioma correspondente.

### Observações
Entendi que todo texto visível deve vir das chaves de tradução e vou aplicar no meu formulário.

---

## Pergunta 7

### Prompt utilizado
Como posso lidar com diferentes formatos de data, hora e moeda em diferentes idiomas?

### Resposta resumida
Usando as classes do pacote `intl`, como `DateFormat` (datas e horas) e `NumberFormat` (números e moeda), que formatam os valores automaticamente conforme o locale — por exemplo, mostrando a data e a moeda no padrão de cada país.

### Observações
O intl formata data e moeda sozinho, de acordo com o idioma/região.

---

## Conclusão
Nesta atividade aprendi o conceito de internacionalização (i18n) e sua importância para tornar o app acessível a usuários de diferentes idiomas e regiões. Entendi como o Flutter faz isso usando os pacotes flutter_localizations e intl junto com arquivos ARB, mantendo os textos separados do código. Vi as boas práticas com os arquivos ARB e os cuidados ao usar o intl, como evitar textos fixos e manter as traduções sincronizadas. Também compreendi como configurar os idiomas no MaterialApp e como formatar datas, horas e moedas conforme o locale usando DateFormat e NumberFormat.
