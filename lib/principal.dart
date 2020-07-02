import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

  @override

  int _menuForma = 1;
  double _sizeFont = 22.0;

  void alteraMenu(int menu, double fonte){
    setState(() {
      this._menuForma = menu;
      this._sizeFont = fonte;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.cached),
            tooltip: "Altera forma do menu",
            onPressed: () {
              if(_menuForma == 1){
                alteraMenu(2, 15.0);

              }
              else{
                alteraMenu(1, 22.0);
              }
            },),
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
                crossAxisCount: _menuForma,
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
                              fontSize: _sizeFont,
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
                              fontSize: _sizeFont,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/paginaMedicamentos');
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('images/medicamentos.png'),
                          color: Colors.black,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("MEDICAMENTOS",
                            style: TextStyle(
                              backgroundColor: Colors.black,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: _sizeFont,
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
                              fontSize: _sizeFont,
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
                              fontSize: _sizeFont,
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
                              fontSize: _sizeFont,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}