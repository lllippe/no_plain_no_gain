class BuscaAlimento {
  String alimento;
  String porcao;
  String calorias;
  String gorduras;
  String carboidratos;
  String proteinas;

  BuscaAlimento({
    required this.alimento,
    required this.porcao,
    required this.calorias,
    required this.gorduras,
    required this.carboidratos,
    required this.proteinas,
  });

  BuscaAlimento.empty()
      : alimento = '',
        porcao = '',
        calorias = '',
        gorduras  = '',
        carboidratos = '',
        proteinas = '';

  BuscaAlimento.fromMap(Map<String, dynamic> map)
      : alimento = map['alimento'],
        porcao = map['porcao'],
        calorias = map['calorias'],
        gorduras = map['gorduras'],
        carboidratos = map['carboidratos'],
        proteinas = map['proteinas'];

  @override
  String toString() {
    return "Alimento: $alimento | Porção: $porcao | Calorias: $calorias"
        " | Gorduras: $gorduras | Carboidratos: $carboidratos"
        " | Proteinas: $proteinas";
  }

  Map<String, dynamic> toMap() {
    return {
      'alimento': alimento,
      'porcao': porcao,
      'calorias': calorias,
      'gorduras': gorduras,
      'carboidratos': carboidratos,
      'proteinas': proteinas,
    };
  }
}
