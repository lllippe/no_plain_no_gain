class Store {
  int id;
  String descricao;
  String url;
  String ramo;
  int contTotal;
  int contMensal;
  int ativo;
  int rateEmpresa;
  String cupom;
  String logo;

  Store({
    required this.id,
    required this.descricao,
    required this.url,
    required this.ramo,
    required this.contTotal,
    required this.contMensal,
    required this.ativo,
    required this.rateEmpresa,
    required this.cupom,
    required this.logo
  });

  Store.empty()
      : id = 0,
        descricao = '',
        url = '',
        ramo = '',
        contTotal = 0,
        contMensal = 0,
        ativo = 0,
        rateEmpresa = 0,
        cupom = '',
        logo = '';

  Store.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        descricao = map['descricao'],
        url = map['url'],
        ramo = map['ramo'],
        contTotal = map['contTotal'],
        contMensal = map['contMensal'],
        ativo = map['ativo'],
        rateEmpresa = map['rateEmpresa'],
        cupom = map['cupom'],
        logo = map['logo'];

  @override
  String toString() {
    return "Descrição: $descricao | Url: $url";
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'descricao': descricao,
      'url': url,
      'ramo' : ramo,
      'contTotal' : contTotal,
      'contMensal' : contMensal,
      'ativo' : ativo,
      'rateEmpresa' : rateEmpresa,
      'cupom' : cupom,
      'logo' : logo,
    };
  }
}
