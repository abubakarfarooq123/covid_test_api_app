import 'package:covid_test_api_app/view/countriesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WordStateModel.dart';
import '../Services/stateservices.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices services = StateServices();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              FutureBuilder(
                future:  services.fetchWordData(),
                  builder: (context,AsyncSnapshot<WordStateModel> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _controller,
                          size: 50,
                        ),
                      );
                    }
                    else{
                     return Column(
                       children: [
                         PieChart(
                           dataMap:  {
                             "Total": double.parse(snapshot.data!.cases!.toString()),
                             "Recovered": double.parse(snapshot.data!.recovered.toString()),
                             "Death": double.parse(snapshot.data!.deaths.toString()),
                           },
                           chartValuesOptions: const ChartValuesOptions(
                             showChartValuesInPercentage: true
                           ),
                           animationDuration: const Duration(milliseconds: 1200),
                           chartType: ChartType.ring,
                           colorList: colorList,
                           legendOptions: const LegendOptions(
                             legendPosition: LegendPosition.left,
                             legendTextStyle: TextStyle(
                               color: Colors
                                   .white, // Change this color to the desired text color
                             ),
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(
                               vertical: MediaQuery.of(context).size.height * 0.06),
                           child: Card(
                             color: Colors.grey.withOpacity(0.5),
                             child: Column(
                               children: [
                                 ReuseableRow(value: snapshot.data!.cases.toString(), title: 'Total'),
                                 ReuseableRow(value: snapshot.data!.deaths.toString(), title: 'Deaths'),
                                 ReuseableRow(value: snapshot.data!.recovered.toString(), title: 'Recovered'),
                                 ReuseableRow(value: snapshot.data!.active.toString(), title: 'Active'),
                                 ReuseableRow(value: snapshot.data!.critical.toString(), title: 'Critical'),
                                 ReuseableRow(value: snapshot.data!.todayDeaths.toString(), title: 'Today Deaths'),
                                 ReuseableRow(value: snapshot.data!.todayRecovered.toString(), title: 'Today Recovered'),

                               ],
                             ),
                           ),
                         ),
                         InkWell(
                           onTap : (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesScreen()));
                           },
                           child: Container(
                             height: 50,
                             width: 230,
                             decoration: BoxDecoration(
                                 color: const Color(0xff1aa260),
                                 borderRadius: BorderRadius.circular(10)),
                             child: const Center(
                               child: Text(
                                 "Track Countries",
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                           ),
                         ),
                       ],
                     );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
