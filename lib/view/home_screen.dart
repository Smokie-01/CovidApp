import 'package:covid_app/model/world_stats_model.dart';
import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/view/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: StatsServices.getWorldStatData(),
                  builder: (context, AsyncSnapshot<WorldStats> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _animationController,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                              animationDuration: const Duration(seconds: 2),
                              colorList: colorList,
                              chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recoverd": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths.toString()),
                              }),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.04),
                            child: Card(
                              child: Column(children: [
                                ReusableRow(title: "Total cases", value: snapshot.data!.cases.toString()),
                                ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: "Recoverd", value: snapshot.data!.recovered.toString()),
                                 ReusableRow(title: "Critical cases", value: snapshot.data!.critical.toString()),
                                 ReusableRow(title: "Todays Death", value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: "Total recovered", value: snapshot.data!.todayRecovered.toString()),
                              ]),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(MediaQuery.of(context).size.width*.8, MediaQuery.of(context).size.height*.06),
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                              },
                              child: Text("Track Countries", style: TextStyle(fontSize:  20,),))
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),), Text(value, style : TextStyle(fontSize: 20))],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
