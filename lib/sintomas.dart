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
                                      _ackAlert(context, 'Sintomas Comuns', 'Febre\nTosse Seca\nCansaço');

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
                                      _ackAlert(context, 'Sintomas Menos Comuns', 'Dores e desconfortos\nDor de garganta\nDiarreia\nConjuntivite\nDor de cabeça\nPerda de paladar ou olfato\nErupção cutânea na pele\nDescoloração dos dedos das mãos ou dos pés');

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
                                      _ackAlert(context, 'Sintomas Graves', 'Dificuldade de respirar ou falta de ar\nDor ou pressão no peito\nPerda de fala ou movimento');

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

Future<void> _ackAlert(context, titulo, texto) {
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

/*
ExpansionTile(
                                    //leading: Icon(Icons.brightness_1, color: Colors.red,),
                                    title: Text("Sintomas Comuns", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    children: <Widget>[
                                      Text("Febre", style: TextStyle(fontSize: 16),),
                                      Text("Tosse Seca", style: TextStyle(fontSize: 16),),
                                      Text("Cansaço", style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                  ExpansionTile(
                                    //leading: Icon(Icons.brightness_1, color: Colors.red,),
                                    title: Text("Sintomas Menos Comuns", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    children: <Widget>[
                                      Text("Dores e desconfortos", style: TextStyle(fontSize: 15),),
                                      Text("Dor de garganta", style: TextStyle(fontSize: 15),),
                                      Text("Diarreia", style: TextStyle(fontSize: 15),),
                                      Text("Conjuntivite", style: TextStyle(fontSize: 15),),
                                      Text("Dor de cabeça", style: TextStyle(fontSize: 15),),
                                      Text("Perda de paladar ou olfato", style: TextStyle(fontSize: 15),),
                                      Text("Erupção cutânea na pele", style: TextStyle(fontSize: 15),),
                                      Text("Descoloração dos dedos das mãos ou dos pés", style: TextStyle(fontSize: 15),),
                                    ],
                                  ),
                                  ExpansionTile(
                                    //leading: Icon(Icons.brightness_1, color: Colors.red,),
                                    title: Text("Sintomas Graves", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    children: <Widget>[
                                      Text("Dificuldade de respirar ou falta de ar", style: TextStyle(fontSize: 16),),
                                      Text("Dor ou pressão no peito", style: TextStyle(fontSize: 16),),
                                      Text("Perda de fala ou movimento", style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
 */