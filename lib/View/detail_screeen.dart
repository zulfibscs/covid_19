 import 'package:covid19/View/world_states.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {

  String name;
  String images;
  int totalCases ,totalDeaths,todayRecovered, active,critical,totalRecoverd,test;

   DetailsScreen({
     required this.name,
     required this.images,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecoverd,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,
   });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.06,),

            Stack(
              alignment: Alignment.topCenter,
              children: [
                Card(
                    child: Column(
                      children: [
                        ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ReuseableRow(title: 'Active', value: widget.active.toString()),
                        ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                        ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ReuseableRow(title: 'Test', value: widget.test.toString()),

                      ],
                    )),
                CircleAvatar(
                  backgroundImage:NetworkImage(widget.images)
                  ,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
