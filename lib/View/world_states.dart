
import 'dart:async';
import 'package:covid19/Services/states_services.dart';
import 'package:covid19/View/contries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Model/WorldStatesModel.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();

}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds:1),
      vsync: this)..repeat();
  @override
    final colorList=<Color>[
      const Color(0xff4285F4),
      const Color(0xff1aa260),
      const Color(0xffde5246),
    ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01),
                FutureBuilder(
                  future: statesServices.fetchWorkedStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                        child:SpinKitFadingCircle(
                          color: Colors.white,
                          // size: 20,
                          // controller: _controller,
                        ));
                  }else{
                    return
                        Column(
                          children: [
                            PieChart(
                              dataMap:{
                                'Totle':double.parse(snapshot.data!.cases.toString()),
                                'Recovered':double.parse(snapshot.data!.recovered.toString()),
                                'Deaths':double.parse(snapshot.data!.deaths.toString()),
                            },
                              chartRadius: MediaQuery.of(context).size.height/7,
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList:colorList,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06,),
                              child: Card(
                                child: Column(

                                  children: [
                                    ReuseableRow(title: 'Total',value:snapshot.data!.cases.toString()),
                                    ReuseableRow(title: 'Deaths',value:snapshot.data!.deaths.toString()),
                                    ReuseableRow(title: 'Recovered',value:snapshot.data!.recovered.toString()),
                                    ReuseableRow(title: 'Active',value:snapshot.data!.active.toString()),
                                    ReuseableRow(title: 'Criticle',value:snapshot.data!.critical.toString()),
                                    ReuseableRow(title: 'Today Death',value:snapshot.data!.todayDeaths.toString()),
                                    ReuseableRow(title: 'Today Recoverd',value:snapshot.data!.todayRecovered.toString()),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ContriesListScreen(),));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color:       const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text('Track Contries'),
                                ),
                              ),
                            )
                          ],
                        );

                  }

                },),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title,value;
  ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

