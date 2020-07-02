class Medicamento{
  String _id;
  String _nome;
  String _dataHora;


  Medicamento(this._id, this._nome, this._dataHora);

  String get id => _id;
  String get nome => _nome;
  String get dataHora => _dataHora;

  Medicamento.map(dynamic obj){
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._dataHora = obj['dataHora'];
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['dataHora'] = _dataHora;
    return map;
  }

  Medicamento.fromMap(Map<String, dynamic> map, String id){
    this._id = id?? '';
    this._nome = map['nome'];
    this._dataHora = map["dataHora"];
  }
}