import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidproject/model/historico.dart';
import 'package:flutter/material.dart';
import 'sintomas.dart';

class cadastroHistorico extends StatefulWidget {
  @override
  _cadastroHistoricoState createState() => _cadastroHistoricoState();
}

class _cadastroHistoricoState extends State<cadastroHistorico> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtInformacoes = TextEditingController();

  String _infoText;

  void resetField(){
    txtNome.text = "";
    txtInformacoes.text = "";
  }


  var db = Firestore.instance;

  void getDocumento(String idDocumento) async {
    DocumentSnapshot doc =
    await db.collection("eventos").document(idDocumento).get();

    setState(() {
      txtNome.text = doc.data['nome'];
      txtInformacoes.text = doc.data['informacao'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String idDocumento = ModalRoute
        .of(context)
        .settings
        .arguments;

    if (idDocumento != null) {
      if (txtNome.text == "" && txtInformacoes == "") {
        getDocumento(idDocumento);
      }
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
              Navigator.pop(context, true);
            },),
          automaticallyImplyLeading: false,
          title: Text("Novo Histórico Médico"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                resetField();
              },
            ),]
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtNome,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Resumo",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtInformacoes,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Informações relevantes",
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 0,
        child: Icon(Icons.check),
        onPressed: (){
          print(txtNome.text);
          print(txtInformacoes);
          if(txtNome.text.isEmpty || txtInformacoes.text.isEmpty){
            ackAlert(context, 'Dados incompletos', 'Informe todos os dados para prosseguir!');
          }else{
            if(idDocumento == null){
              inserir(context,
                  Historico(idDocumento,
                      txtNome.text, txtInformacoes.text));
            }else{
              atualizar(context,
                  Historico(idDocumento,
                      txtNome.text, txtInformacoes.text));
            }
          }
        },
      ),

    );

  }

  void inserir(BuildContext context, Historico historico) async{
    await db.collection("historico").add(
        {
          "nome": historico.nome,
          "informacoes": historico.informacoes,
        }
    );
    Navigator.pop(context);
  }

  void atualizar(BuildContext context, Historico historico) async{
    await db.collection("historico").document(historico.id)
        .updateData(
        {
          "nome": historico.nome,
          "informacoes": historico.informacoes,
        }
    );
    Navigator.pop(context);
  }

}
