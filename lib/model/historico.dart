class Historico{
  String _id;
  String _nome;
  String _informacoes;


  Historico(this._id, this._nome, this._informacoes);

  String get id => _id;
  String get nome => _nome;
  String get informacoes => _informacoes;

  Historico.map(dynamic obj){
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._informacoes = obj['informacoes'];
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['informacoes'] = _informacoes;
    return map;
  }

  Historico.fromMap(Map<String, dynamic> map, String id){
    this._id = id?? '';
    this._nome = map['nome'];
    this._informacoes = map["informacoes"];
  }
}