import 'package:flutter/material.dart';
import 'package:covidproject/main.dart';

class PaginaPrevencao extends StatelessWidget {
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
              },
            ),
            automaticallyImplyLeading: false,
            title: Text("Prevenção"),
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
              ),
            ],
          ),
          body: CustomScrollView(primary: false, slivers: <Widget>[
            SliverPadding(
                padding: const EdgeInsets.all(2),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 1,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              openBrowserTab(
                                  "https://sbpt.org.br/portal/covid-19-oms/");
                            },

                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child:
                                  Image.asset("images/Prevenacao/lavarmaos.png"),
                              color: Colors.black,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "PREVENÇÃO",
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
                          children: <Widget>[
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Lave as mãos com água e sabão ou higienizador à base de álcool para matar vírus que podem estar nas suas mãos.'),

                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Mantenha pelo menos 1 metro de distância entre você e qualquer pessoa que esteja tossindo ou espirrando. Quando alguém tosse ou espirra, pulveriza pequenas gotas líquidas do nariz ou da boca, que podem conter vírus. Se você estiver muito próximo, poderá inspirar as gotículas – inclusive do vírus da COVID-19 se a pessoa que tossir tiver a doença.'),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Evite tocar nos olhos, nariz e boca. As mãos tocam muitas superfícies e podem ser infectadas por vírus. Uma vez contaminadas, as mãos podem transferir o vírus para os olhos, nariz ou boca. A partir daí, o vírus pode entrar no corpo da pessoa e deixá-la doente.'),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Certifique-se de que você e as pessoas ao seu redor seguem uma boa higiene respiratória. Isso significa cobrir a boca e o nariz com a parte interna do cotovelo ou lenço quando tossir ou espirrar (em seguida, descarte o lenço usado imediatamente). Gotículas espalham vírus. Ao seguir uma boa higiene respiratória, você protege as pessoas ao seu redor contra vírus responsáveis por resfriado, gripe e COVID-19.'),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Fique em casa se não se sentir bem. Se você tiver febre, tosse e dificuldade em respirar, procure atendimento médico. Siga as instruções da sua autoridade sanitária nacional ou local, porque elas sempre terão as informações mais atualizadas sobre a situação em sua área.'),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Pessoas doentes devem adiar ou evitar viajar para as áreas afetadas por coronavírus. Áreas afetadas são países, áreas, províncias ou cidades onde há transmissão contínua – não áreas com apenas casos importados.'),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        'Os viajantes que retornam das áreas afetadas devem monitorar seus sintomas por 14 dias e seguir os protocolos nacionais dos países receptores; e se ocorrerem sintomas, devem entrar em contato com um médico e informar sobre o histórico de viagem e os sintomas.'),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                openBrowserTab(
                                    "https://sbpt.org.br/portal/covid-19-oms/");
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(32.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text('Fonte: SBPT'),
                                      Text('Sociedade Brasileira de Pneumologia e Tisiologia', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline, decorationColor: Colors.blue[500]),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))
          ])),
    );
  }
}