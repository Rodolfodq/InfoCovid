import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'cadastroMedicamento.dart';
import 'model/medicamento.dart';
import 'main.dart';

class Medicamentos extends StatefulWidget {
  @override
  _MedicamentosState createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {

  final db = Firestore.instance;
  final String colecao = "medicamentos";

  List<Medicamento> lista = List();

  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    listen?.cancel();

    listen = db.collection(colecao).snapshots().listen((res) {
      setState(() {
        lista = res.documents
            .map((doc) => Medicamento.fromMap(doc.data, doc.documentID))
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
        '/cadastroMedicamento':(context) => cadastroMedicamento(),
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
          title: Text("Medicamentos"),
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
                        subtitle: Text(lista[index].dataHora, style: TextStyle(fontSize: 16)),
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
                              "/cadastroMedicamento",
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
            Navigator.pushNamed(context, '/cadastroMedicamento', arguments: null);
          },

        ),

      ),
    );
  }
}
