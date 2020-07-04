import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidproject/model/historico.dart';
import 'package:flutter/material.dart';
import 'package:covidproject/cadastroHistorico.dart';
import 'dart:async';


class paginaHistorico extends StatefulWidget {
  @override
  _paginaHistoricoState createState() => _paginaHistoricoState();
}

class _paginaHistoricoState extends State<paginaHistorico> {

  final db = Firestore.instance;
  final String colecao = "historico";

  List<Historico> lista = List();

  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    listen?.cancel();

    listen = db.collection(colecao).snapshots().listen((res) {
      setState(() {
        lista = res.documents
            .map((doc) => Historico.fromMap(doc.data, doc.documentID))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/cadastroHistorico':(context) => cadastroHistorico(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
              Navigator.pop(context, true);
            },),
          automaticallyImplyLeading: false,
          title: Text("Histórico Médico"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //Navigator.pushNamed(context, '/login');
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
            ),],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection(colecao).snapshots(),

          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                List<DocumentSnapshot> docs = snapshot.data.documents;
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(
                          lista[index].nome,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(lista[index].informacoes, style: TextStyle(fontSize: 16)),
                        trailing: IconButton(
                          icon: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              db.collection(colecao).document(lista[index].id).delete();
                            },
                          ),
                        ),
                        onTap: (){
                          Navigator.pushNamed(
                              context,
                              "/cadastroHistorico",
                              arguments: lista[index].id
                          );
                        },
                      );
                    }
                );
            }
          },
        ),

        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, "/cadastroHistorico", arguments: null);
          },

        ),

      ),
    );
  }
}
