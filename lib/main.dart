import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidproject/principal.dart';
import 'package:covidproject/sobre.dart';
import 'package:covidproject/sintomas.dart';
import 'package:covidproject/prevencao.dart';
import 'package:covidproject/dados.dart';
import 'package:covidproject/graficos.dart';
import 'package:covidproject/MeuAcompanhamento.dart';
import 'package:covidproject/cadastroAcompanhamento.dart';
import 'package:covidproject/medicamentos.dart';
import 'package:covidproject/historicoSaude.dart';
import 'package:covidproject/cadastroHistorico.dart';
import 'package:covidproject/model/loginFirebase.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'cadastroMedicamento.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Info Covid-19 - Login",
    initialRoute: '/login',
    routes: {
      '/login': (context) => MyApp(),
      '/paginaPrincipal': (context) => PaginaPrincipal(),
      '/paginaSobre': (context) => PaginaSobre(),
      '/paginaSintomas': (context) => PaginaSintomas(),
      '/paignaPrevencao': (context) => PaginaPrevencao(),
      '/paginaDados': (context) => PageDados(),
      '/paginaGraficos': (context) => PaginaGraficos(),
      '/paginaAcompanhamento': (context) => PaginaAcompanhamento(),
      '/cadastro':(context) => CadastroAcompanhamento(),
      '/paginaMedicamentos': (context) => Medicamentos(),
      '/cadastroMedicamento':(context) => cadastroMedicamento(),
      '/paginaHistorico': (context) => paginaHistorico(),
      '/cadastroHistorico':(context) => cadastroHistorico()
    },
  ));
}

openBrowserTab(enderecoUrl) async {
  await FlutterWebBrowser.openWebPage(url: enderecoUrl, androidToolbarColor: Colors.black);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final db = Firestore.instance;
  final String colecao = "login";

  List<Login> lista = List();

  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    listen?.cancel();

    listen = db.collection(colecao).snapshots().listen((res) {
      setState(() {
        lista = res.documents
            .map((doc) => Login.fromMap(doc.data, doc.documentID))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  void _resetField() {
    emailController.text = "";
    senhaController.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });

  }

  Future _logar(String usuario, String senha) async{
    for(int i = 0; i < lista.length; i++){
      if(usuario == lista[i].user && senha == lista[i].password){
        Navigator.pushNamed(context, '/paginaPrincipal');
        break;
      }
      else{
        ackAlert(context, "Login inválido", "Usuário ou senha incorretos.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info Covid-19"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField, //
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.00, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                "images/login.png",
                height: 150.0,
                width: 150.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Usuário",
                    labelStyle: TextStyle(color: Colors.black26)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: emailController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Informe seu usuário";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.black26, fontSize: 25.0)),
                textAlign: TextAlign.center,
                controller: senhaController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Informe sua senha";
                  }
                },
                ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _logar(emailController.text, senhaController.text);
                      }
                    }, //enviar dados
                    child: Text(
                      "ENTRAR",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
