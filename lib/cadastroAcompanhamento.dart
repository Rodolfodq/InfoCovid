import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'model/eventos.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:covidproject/sintomas.dart';

class CadastroAcompanhamento extends StatefulWidget {
  @override
  _CadastroAcompanhamentoState createState() => _CadastroAcompanhamentoState();
}

class _CadastroAcompanhamentoState extends State<CadastroAcompanhamento> {

  TextEditingController txtObservacao = TextEditingController();
  TextEditingController txtDataHora = TextEditingController();

  String _infoText;

  void resetField(){
    txtObservacao.text = "";
    txtDataHora.text = "";
  }


  var db = Firestore.instance;

  void getDocumento(String idDocumento) async {
    DocumentSnapshot doc =
    await db.collection("eventos").document(idDocumento).get();

    setState(() {
      txtObservacao.text = doc.data['observacao'];
      txtDataHora.text = doc.data['datahora'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String idDocumento = ModalRoute
        .of(context)
        .settings
        .arguments;

    if (idDocumento != null) {
      if (txtObservacao.text == "" && txtDataHora == "") {
        getDocumento(idDocumento);
      }
    }
    final format = DateFormat("dd-MM-yyyy - HH:mm ");


    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
                Navigator.pop(context, true);
                },),
            automaticallyImplyLeading: false,
            title: Text("Novo Acompanhamento"),
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
              controller: txtObservacao,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Ocorrência",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children:<Widget>[
                DateTimeField(
                  decoration: InputDecoration(
                    labelText: "Data e Hora da Ocorrência",
                    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                  controller: txtDataHora,
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime.now());
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                  )
              ],
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
          if(txtObservacao.text.isEmpty || txtDataHora.text.isEmpty){
            ackAlert(context, 'Dados incompletos', 'Informe todos os dados para prosseguir!');
          }else{
            if(idDocumento == null){
              inserir(context,
                  Evento(idDocumento,
                      txtObservacao.text, txtDataHora.text));
            }else{
              atualizar(context,
                  Evento(idDocumento,
                      txtObservacao.text, txtDataHora.text));
            }
          }
        },
      ),

    );

  }
  
  void inserir(BuildContext context, Evento evento) async{
    await db.collection("eventos").add(
      {
        "observacao": evento.observacao,
        "dataHora": evento.dataHora,
      }
    );
    Navigator.pop(context);
  }

  void atualizar(BuildContext context, Evento evento) async{
    await db.collection("eventos").document(evento.id)
        .updateData(
        {
          "observacao": evento.observacao,
          "dataHora": evento.dataHora,
        }
    );
    Navigator.pop(context);
  }
}
