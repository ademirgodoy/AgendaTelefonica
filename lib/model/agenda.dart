class Agenda {
// Atributos:
  int _idAgenda;
  String _nome;
  String _telefone;
  String _data;

  Agenda(this._nome, this._telefone, this._data);

  Agenda.comID(this._idAgenda,this._nome, this._telefone, this._data);

  Agenda.fromObject(dynamic o) {
    this._idAgenda = o["id"];
    this._nome = o["nome"];
    this._telefone = o["telefone"];
    this._data = o["data"];
  }

  // Getters...
  int get idAgenda => _idAgenda;
  String get nome => _nome;
  String get telefone => _telefone;
  String get data => _data;

  // Setters...
  set nome (String novoNome) {
    _nome = novoNome;
  }
  set telefone (String novoTelefone) {
    _telefone = novoTelefone;
  }
  set data(String novaData) {
    _data = novaData;
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["nome"] = _nome;
    map["telefone"] = _telefone;
    map["data"] = _data;
    if (_idAgenda != null) {
      map["idagenda"] = _idAgenda;
    }
    return map;
  }

}