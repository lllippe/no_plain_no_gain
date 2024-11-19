class BancoConhecimento {
  String descricao;
  String endereco;

  BancoConhecimento({
    required this.descricao,
    required this.endereco,
  });

  BancoConhecimento.empty()
      : descricao = '',
        endereco = '';

  BancoConhecimento.fromMap(Map<String, dynamic> map)
      : descricao = map['descricao'],
        endereco = map['endereco'];

  @override
  String toString() {
    return "Descrição: $descricao | Endereço: $endereco";
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'endereco': endereco,
    };
  }
}
