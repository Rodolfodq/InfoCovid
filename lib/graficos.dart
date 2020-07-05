import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covidproject/counter.dart';

var request_dados;
var dicionario;

Future countriesDados(country) async {
  request_dados = 'https://api.covid19api.com/dayone/country/$country';
  http.Response response = await http.get(request_dados);
  List<dynamic> body = jsonDecode(response.body);

  int confirmados, mortes, recuperados, ativos;
  var data, data2;
  List<dynamic> dict;

  confirmados = body[body.length-1]["Confirmed"];
  mortes = body[body.length-1]["Deaths"];
  recuperados = body[body.length-1]["Recovered"];
  ativos = body[body.length-1]["Active"];
  data2 = body[body.length-1]["Date"];
  data = data2.substring(0,10);// dict[i][4]
  dict = [confirmados, mortes, recuperados, ativos, data];

  return dict;
}


class PaginaGraficos extends StatefulWidget {
  @override
  _PaginaGraficosState createState() => _PaginaGraficosState();
}

class _PaginaGraficosState extends State<PaginaGraficos> {
  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          automaticallyImplyLeading: false,
          title: Text("$country"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
          ],
        ),
        body: Column(          
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
            child: FutureBuilder(
              future: countriesDados(country),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 300.0,
                      height: 300.0,
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    );
                  default:
                    if(snapshot.hasError) return Container(
                    );
                    else return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.red,
                                  number: snapshot.data[3],
                                  title: "Ativos",
                                ),
                              ),
                            ),
                            //SizedBox(height: 30),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.black,
                                  number:snapshot.data[1],
                                  title: "Mortes",
                                ),
                              ),
                            ),
                            //SizedBox(height: 30),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.green,
                                  number: snapshot.data[2],
                                  title: "Recuperados",
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.orange,
                                  number: snapshot.data[0],
                                  title: "Confirmados",
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(25.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Última atualização: \n" + snapshot.data[4],
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                }
              }
            ),
          ),
        ]
        ),
    );

  }
}