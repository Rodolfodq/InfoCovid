import 'package:covidproject/main.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covidproject/dados.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covidproject/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covidproject/counter.dart';
import 'package:intl/intl.dart';



var request_dados;
var dicionario;

Future countriesDados(country) async {
  request_dados = 'https://api.covid19api.com/dayone/country/$country';
  http.Response response = await http.get(request_dados);
  //print(json.decode(response.body));
  //print(response.runtimeType);
  //print(response.body);
  //print(response.body[25773].isNotEmpty);
  int i = 0;
  Map<int, List> dict = Map();
  int confirmados, mortes, recuperados, ativos;
  var data, data2, format_data;
  //DateTime format_data;
  do {
    confirmados = json.decode(response.body)[i]["Confirmed"]; // dict[i][0]
    mortes = json.decode(response.body)[i]["Deaths"]; // // dict[i][1]
    recuperados = json.decode(response.body)[i]["Recovered"]; // dict[i][2]
    ativos = json.decode(response.body)[i]["Active"]; // dict[i][3]
    data2 = json.decode(response.body)[i]["Date"];
    data = data2.substring(0,10);// dict[i][4]
    dict[0] = [confirmados, mortes, recuperados, ativos, data];
    i++;
  } while (i < 109);


  //print("Print type");
  //print(dict.runtimeType);
  return dict;
}




class PaginaGraficos extends StatefulWidget {
  @override
  _PaginaGraficosState createState() => _PaginaGraficosState();
}

class _PaginaGraficosState extends State<PaginaGraficos> {
  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          automaticallyImplyLeading: false,
          title: Text("$country"),
          centerTitle: true,
          backgroundColor: Colors.black,
          //automaticallyImplyLeading: false,
          actions: <Widget>[
            /*IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),*/
          ],
        ),
        body: Column(          
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
            child: FutureBuilder(
              future: countriesDados(country),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 300.0,
                      height: 300.0,
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    );
                  default:
                    if(snapshot.hasError) return Container(
                    );
                    else return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            /*Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Informações sobre: $country"
                                    )
                                  ],
                                ),
                              ),
                            ),*/
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.red,
                                  number: snapshot.data[0][3],
                                  title: "Ativos",
                                ),
                              ),
                            ),
                            //SizedBox(height: 30),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.black,
                                  number:snapshot.data[0][1],
                                  title: "Mortes",
                                ),
                              ),
                            ),
                            //SizedBox(height: 30),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.green,
                                  number: snapshot.data[0][2],
                                  title: "Recuperados",
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Counter(
                                  color: Colors.orange,
                                  number: snapshot.data[0][0],
                                  title: "Confirmados",
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(25.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Última atualização: \n" + snapshot.data[0][4],
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                }
              }
            ),
          ),
        ]),
    ));

  }
}

/*
class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Cancelar e voltar ao menu",
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          automaticallyImplyLeading: false,
          title: Text("Gráficos"),
          centerTitle: true,
          backgroundColor: Colors.black,
          //automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[ AspectRatio(
            aspectRatio: 1.23,
            child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(
                colors: const [
                  Color(0xff2c274c),
                  Color(0xff46426c),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
             child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 37,
                    ),
                    const Text(
                      'Unfold Shop 2018',
                      style: TextStyle(
                        color: Color(0xff827daa),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Monthly Sales',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                        child: LineChart(
                          isShowingMainData ? sampleData1() : sampleData2(),
                          swapAnimationDuration: const Duration(milliseconds: 250),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowingMainData = !isShowingMainData;
                    });
                  },
                )
              ],
            ),
          ),
          ),
        ]),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
*/