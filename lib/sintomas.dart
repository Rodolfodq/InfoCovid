import 'package:flutter/material.dart';


class PaginaSintomas extends StatefulWidget {
  @override
  _PaginaSintomasState createState() => _PaginaSintomasState();
}

class _PaginaSintomasState extends State<PaginaSintomas> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: "Cancelar e voltar ao menu",
              onPressed: () {
                  Navigator.pop(context, true);
            },),
          automaticallyImplyLeading: false,
            title: Text("Sintomas"),
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
            ),],
            ),
            body: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                      padding: const EdgeInsets.all(2),
                      sliver: SliverGrid.count(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 1,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      "images/Sintomas/atchim.png"),
                                  color: Colors.black,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text("SINTOMAS",
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height * 0.35,
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                reverse: false,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      ackAlert(context, 'Sintomas Comuns', 'Febre\nTosse Seca\nCansaço');

                                    },
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(32.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                'Sintomas Comuns'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      ackAlert(context, 'Sintomas Menos Comuns', 'Dores e desconfortos\nDor de garganta\nDiarreia\nConjuntivite\nDor de cabeça\nPerda de paladar ou olfato\nErupção cutânea na pele\nDescoloração dos dedos das mãos ou dos pés');

                                    },
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(32.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                'Sintomas Menos Comuns'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      ackAlert(context, 'Sintomas Graves', 'Dificuldade de respirar ou falta de ar\nDor ou pressão no peito\nPerda de fala ou movimento');

                                    },
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(32.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                'Sintomas Graves'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                      ))
                ]))



    );
    }
}

Future<void> ackAlert(context, titulo, texto) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(texto),
        elevation: 24.0,
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}