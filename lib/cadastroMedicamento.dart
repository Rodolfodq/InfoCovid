import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'model/medicamento.dart';
import 'medicamentos.dart';
import 'sintomas.dart';


class cadastroMedicamento extends StatefulWidget {
  @override
  _cadastroMedicamentoState createState() => _cadastroMedicamentoState();
}

class _cadastroMedicamentoState extends State<cadastroMedicamento> {

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtDataHora = TextEditingController();

  String _infoText;

  void resetField(){
    txtNome.text = "";
    txtDataHora.text = "";
  }


  var db = Firestore.instance;

  void getDocumento(String idDocumento) async {
    DocumentSnapshot doc =
    await db.collection("medicametnos").document(idDocumento).get();

    setState(() {
      txtNome.text = doc.data['nome'];
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
      if (txtNome.text == "" && txtDataHora == "") {
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
            title: Text("Nova Medicação"),
            centerTitle: true,
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  resetField();
                },
              ),
            ]
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
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  labelText: "Nome do Medicamento",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  DateTimeField(
                    decoration: InputDecoration(
                      labelText: "Data e Hora do Uso",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300),
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
                          TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
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
          onPressed: () {
            if (txtNome.text.isEmpty || txtDataHora.text.isEmpty) {
              ackAlert(context, 'Dados incompletos',
                  'Informe todos os dados para prosseguir!');
            } else {
              if (idDocumento == null) {
                inserir(context,
                    Medicamento(idDocumento,
                        txtNome.text, txtDataHora.text));
              } else {
                atualizar(context,
                    Medicamento(idDocumento,
                        txtNome.text, txtDataHora.text));
              }
            }
          },
        ),

      );

    }
      void inserir(BuildContext context, Medicamento medicamento) async {
        await db.collection("medicamentos").add(
            {
              "nome": medicamento.nome,
              "dataHora": medicamento.dataHora,
            }
        );
        Navigator.pop(context);
      }

      void atualizar(BuildContext context, Medicamento medicamento) async {
        await db.collection("medicamentos").document(medicamento.id)
            .updateData(
            {
              "nome": medicamento.nome,
              "dataHora": medicamento.dataHora,
            }
        );
        Navigator.pop(context);
      }

  }
