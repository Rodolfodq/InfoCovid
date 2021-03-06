class Evento{
  String _id;
  String _observacao;
  String _dataHora;


  Evento(this._id, this._observacao, this._dataHora);

  String get id => _id;
  String get observacao => _observacao;
  String get dataHora => _dataHora;

  Evento.map(dynamic obj){
    this._id = obj['id'];
    this._observacao = obj['observacao'];
    this._dataHora = obj['dataHora'];
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['observacao'] = _observacao;
    map['dataHora'] = _dataHora;
    return map;
  }

  Evento.fromMap(Map<String, dynamic> map, String id){
    this._id = id?? '';
    this._observacao = map['observacao'];
    this._dataHora = map["dataHora"];
  }
}