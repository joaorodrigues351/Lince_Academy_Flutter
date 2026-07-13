import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const MyApp());
}

enum TipoSanguineo {
  aPositivo('A+', Colors.blue),
  aNegativo('A-', Colors.red),
  bPositivo('B+', Colors.purple),
  bNegativo('B-', Colors.orange),
  oPositivo('O+', Colors.green),
  oNegativo('O-', Colors.yellow),
  abPositivo('AB+', Colors.cyan),
  abNegativo('AB-', Colors.white);

  const TipoSanguineo(this.descricao, this.cor);

  /// Como o tipo aparece para o usuário (ex.: A+)
  final String descricao;

  /// Cor do item da pessoa na listagem
  final Color cor;
}

class Pessoa {
  const Pessoa({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.github,
    required this.tipoSanguineo,
  });

  final String nome;
  final String email;
  final String telefone;
  final String github;
  final TipoSanguineo tipoSanguineo;

  Pessoa copyWith({
    String? nome,
    String? email,
    String? telefone,
    String? github,
    TipoSanguineo? tipoSanguineo,
  }) {
    return Pessoa(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      github: github ?? this.github,
      tipoSanguineo: tipoSanguineo ?? this.tipoSanguineo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Pessoa &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.github == github &&
        other.tipoSanguineo == tipoSanguineo;
  }

  @override
  int get hashCode => Object.hash(nome, email, telefone, github, tipoSanguineo);
}

class EstadoListaDePessoas with ChangeNotifier {
  final _listaDePessoas = <Pessoa>[];

  List<Pessoa> get pessoas => List.unmodifiable(_listaDePessoas);

  void incluir(Pessoa pessoa) {
    _listaDePessoas.add(pessoa);
    notifyListeners();
  }

  void excluir(Pessoa pessoa) {
    _listaDePessoas.remove(pessoa);
    notifyListeners();
  }

  /// Substitui os dados de uma pessoa ja cadastrada
  void alterar(Pessoa original, Pessoa alterada) {
    final posicao = _listaDePessoas.indexOf(original);

    if (posicao == -1) {
      return;
    }

    _listaDePessoas[posicao] = alterada;
    notifyListeners();
  }

  /// Filtra as pessoas pelo texto (nome, e-mail, telefone ou github) e pelo
  /// tipo sanguineo, ambos opcionais
  List<Pessoa> filtrar({String texto = '', TipoSanguineo? tipoSanguineo}) {
    final busca = texto.trim().toLowerCase();

    return _listaDePessoas.where((pessoa) {
      final combinaTipo =
          tipoSanguineo == null || pessoa.tipoSanguineo == tipoSanguineo;

      final combinaTexto = busca.isEmpty ||
          pessoa.nome.toLowerCase().contains(busca) ||
          pessoa.email.toLowerCase().contains(busca) ||
          pessoa.telefone.toLowerCase().contains(busca) ||
          pessoa.github.toLowerCase().contains(busca);

      return combinaTipo && combinaTexto;
    }).toList();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EstadoListaDePessoas(),
      child: MaterialApp(
        title: 'AP1 - Tipos sanguíneos',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: darkBlue,
        ),
        debugShowCheckedModeBanner: false,
        home: const TelaInicial(),
      ),
    );
  }
}

/// Tela 1: menu com os botões que direcionam para as demais telas
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final total = context.watch<EstadoListaDePessoas>().pessoas.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Tipos sanguíneos')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pessoas cadastradas: $total',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('Ver pessoas cadastradas'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const TelaListagem(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Incluir nova pessoa'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const TelaFormulario(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tela 2: listagem das pessoas, com o filtro
class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  final _buscaController = TextEditingController();

  TipoSanguineo? _tipoFiltrado;

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<EstadoListaDePessoas>();

    final pessoas = estado.filtrar(
      texto: _buscaController.text,
      tipoSanguineo: _tipoFiltrado,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Pessoas cadastradas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const TelaFormulario(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _buscaController,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar por nome, e-mail, telefone ou GitHub',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) => setState(() {}),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<TipoSanguineo?>(
                  initialValue: _tipoFiltrado,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar por tipo sanguíneo',
                    border: OutlineInputBorder(),
                  ),
                  items: <DropdownMenuItem<TipoSanguineo?>>[
                    const DropdownMenuItem<TipoSanguineo?>(
                      child: Text('Todos os tipos'),
                    ),
                    for (final tipo in TipoSanguineo.values)
                      DropdownMenuItem<TipoSanguineo?>(
                        value: tipo,
                        child: Text(tipo.descricao),
                      ),
                  ],
                  onChanged: (tipo) => setState(() => _tipoFiltrado = tipo),
                ),
              ],
            ),
          ),
          Expanded(
            child: pessoas.isEmpty
                ? const Center(child: Text('Nenhuma pessoa encontrada'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
                    itemCount: pessoas.length,
                    itemBuilder: (context, indice) => _ItemDaPessoa(
                      pessoa: pessoas[indice],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Item da listagem, colorido conforme o tipo sanguíneo da pessoa
class _ItemDaPessoa extends StatelessWidget {
  const _ItemDaPessoa({required this.pessoa});

  final Pessoa pessoa;

  @override
  Widget build(BuildContext context) {
    final cor = pessoa.tipoSanguineo.cor;

    // Alguns tipos usam cores claras (branco, amarelo, ciano), entao o texto
    // precisa acompanhar a luminosidade do fundo para continuar legivel
    final corDoTexto = ThemeData.estimateBrightnessForColor(cor) == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Card(
      color: cor,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          pessoa.nome,
          style: TextStyle(color: corDoTexto, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(pessoa.email, style: TextStyle(color: corDoTexto)),
            Text(pessoa.telefone, style: TextStyle(color: corDoTexto)),
            Text(pessoa.github, style: TextStyle(color: corDoTexto)),
          ],
        ),
        trailing: Text(
          pessoa.tipoSanguineo.descricao,
          style: TextStyle(
            color: corDoTexto,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => TelaDetalhes(pessoa: pessoa),
          ),
        ),
      ),
    );
  }
}

/// Tela 3: inclusão e edição de pessoas
class TelaFormulario extends StatefulWidget {
  const TelaFormulario({super.key, this.pessoa});

  /// Quando informada, o formulário edita essa pessoa em vez de incluir
  final Pessoa? pessoa;

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _githubController;

  late TipoSanguineo _tipoSanguineo;

  bool get _editando => widget.pessoa != null;

  @override
  void initState() {
    super.initState();

    final pessoa = widget.pessoa;

    _nomeController = TextEditingController(text: pessoa?.nome ?? '');
    _emailController = TextEditingController(text: pessoa?.email ?? '');
    _telefoneController = TextEditingController(text: pessoa?.telefone ?? '');
    _githubController = TextEditingController(text: pessoa?.github ?? '');
    _tipoSanguineo = pessoa?.tipoSanguineo ?? TipoSanguineo.aPositivo;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  String? _obrigatorio(String? valor, String campo) {
    if ((valor ?? '').trim().isEmpty) {
      return 'Informe o $campo';
    }

    return null;
  }

  String? _validarEmail(String? valor) {
    final email = (valor ?? '').trim();

    if (email.isEmpty) {
      return 'Informe o e-mail';
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Informe um e-mail válido';
    }

    return null;
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pessoa = Pessoa(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      github: _githubController.text.trim(),
      tipoSanguineo: _tipoSanguineo,
    );

    final estado = context.read<EstadoListaDePessoas>();
    final original = widget.pessoa;

    if (original != null) {
      estado.alterar(original, pessoa);
    } else {
      estado.incluir(pessoa);
    }

    // Devolve a pessoa salva para a tela anterior manter os dados atualizados
    Navigator.of(context).pop(pessoa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar pessoa' : 'Incluir pessoa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (valor) => _obrigatorio(valor, 'nome completo'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (valor) => _obrigatorio(valor, 'telefone'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _githubController,
                decoration: const InputDecoration(
                  labelText: 'Link do GitHub',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (valor) => _obrigatorio(valor, 'link do GitHub'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TipoSanguineo>(
                initialValue: _tipoSanguineo,
                decoration: const InputDecoration(
                  labelText: 'Tipo sanguíneo',
                  border: OutlineInputBorder(),
                ),
                items: <DropdownMenuItem<TipoSanguineo>>[
                  for (final tipo in TipoSanguineo.values)
                    DropdownMenuItem<TipoSanguineo>(
                      value: tipo,
                      child: Row(
                        children: [
                          Container(width: 16, height: 16, color: tipo.cor),
                          const SizedBox(width: 8),
                          Text(tipo.descricao),
                        ],
                      ),
                    ),
                ],
                onChanged: (tipo) => setState(
                  () => _tipoSanguineo = tipo ?? _tipoSanguineo,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _salvar,
                child: Text(_editando ? 'Salvar alterações' : 'Incluir pessoa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tela 4: detalhes da pessoa, com as ações de editar e excluir
class TelaDetalhes extends StatefulWidget {
  const TelaDetalhes({super.key, required this.pessoa});

  final Pessoa pessoa;

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  late Pessoa _pessoa = widget.pessoa;

  Future<void> _editar() async {
    final alterada = await Navigator.of(context).push<Pessoa>(
      MaterialPageRoute<Pessoa>(
        builder: (context) => TelaFormulario(pessoa: _pessoa),
      ),
    );

    if (alterada != null) {
      setState(() => _pessoa = alterada);
    }
  }

  Future<void> _excluir() async {
    final excluida = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => TelaExclusao(pessoa: _pessoa),
      ),
    );

    if (excluida ?? false) {
      if (!mounted) {
        return;
      }

      // A pessoa nao existe mais, volta para a listagem
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pessoa.nome)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: _pessoa.tipoSanguineo.cor,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  _pessoa.tipoSanguineo.descricao,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: ThemeData.estimateBrightnessForColor(
                              _pessoa.tipoSanguineo.cor,
                            ) ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _Dado(rotulo: 'Nome completo', valor: _pessoa.nome),
          _Dado(rotulo: 'E-mail', valor: _pessoa.email),
          _Dado(rotulo: 'Telefone', valor: _pessoa.telefone),
          _Dado(rotulo: 'Link do GitHub', valor: _pessoa.github),
          _Dado(
            rotulo: 'Tipo sanguíneo',
            valor: _pessoa.tipoSanguineo.descricao,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Editar'),
            onPressed: _editar,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Excluir'),
            onPressed: _excluir,
          ),
        ],
      ),
    );
  }
}

class _Dado extends StatelessWidget {
  const _Dado({required this.rotulo, required this.valor});

  final String rotulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(rotulo, style: Theme.of(context).textTheme.labelMedium),
      subtitle: Text(valor, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

/// Tela 5: confirmação da exclusão de uma pessoa
class TelaExclusao extends StatelessWidget {
  const TelaExclusao({super.key, required this.pessoa});

  final Pessoa pessoa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excluir pessoa')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber, size: 64),
            const SizedBox(height: 16),
            Text(
              'Deseja mesmo excluir ${pessoa.nome}?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Essa ação não pode ser desfeita.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text('Excluir'),
              onPressed: () {
                context.read<EstadoListaDePessoas>().excluir(pessoa);
                Navigator.of(context).pop(true);
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
