import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PaginaPrincipal extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Menu"),
          centerTitle: true,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
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
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/paginaDados');
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('images/estatisticas.png'),
                          color: Colors.black,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("ESTATÍSTICAS",
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
                      Navigator.pushNamed(context, '/paginaAcompanhamento');
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('images/acompanhamento.png'),
                          color: Colors.black,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("ACOMPANHAMENTO",
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
                      Navigator.pushNamed(context, '/paignaPrevencao');
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('images/prevencao.png'),
                          color: Colors.black,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("PREVENÇÃO",
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
                      Navigator.pushNamed(context, '/paginaSintomas');
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('images/sintomas.png'),
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
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/paginaSobre');
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('images/sobre.png'),
                          color: Colors.black,
                      ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("SOBRE",
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
                  /*Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution is coming...'),
                    color: Colors.green[500],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.green[600],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
