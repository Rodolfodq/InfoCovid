import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidproject/main.dart';

class PaginaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          automaticallyImplyLeading: false,
          title: Text("Sobre"),
          centerTitle: true,
          backgroundColor: Colors.black,
          //automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //Navigator.pushNamed(context, '/login');
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
            ),
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            //color: Colors.red,
            child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          openBrowserTab("https://github.com/Rodolfodq");
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'images/Sobre/github.png',
                              height: 170.0,
                              width: 170.0,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                  "GITHUB",
                                  style: TextStyle(
                                    backgroundColor: Colors.black,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          openBrowserTab("https://www.linkedin.com/in/rodolfo-dantas-queiroz-66b2a6125/");
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'images/Sobre/linkedin.png',
                              height: 165.0,
                              width: 165.0,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "LINKEDIN",
                                style: TextStyle(
                                  backgroundColor: Colors.black,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(                    
                    children: <Widget>[                      
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Card(
                          color: Colors.black,
                          child: Container(
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              children: <Widget>[
                                Text(texto_card,
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                            ],
                          ),
                         ),
                        ),
                      ),
                  ])
                ],
              ),
            ),
          );
  }
}

const texto_card = "Este aplicativo tem o objetivo de apresentar informações atualizadas sobre a pandemia de COVID-19, além de apresentar os principais sintomas e como se prevenir de forma eficaz.\n\n"
    "Todas as interfaces deste projeto foram desenvolvidas utilizando o framework Flutter, desenvolvido pelo Google na linguagem Dart.\n\n"
    "O desenvolvedor deste projeto é aluno do quarto semestre do curso de Análise e Desenvolvimento de Sistemas da FATEC - Ribeirão Preto. O seu repositório no Github e perfil no Linkedin podem ser acessados tocando os ícones acima.";
