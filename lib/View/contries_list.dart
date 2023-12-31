import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:covid19/Services/states_services.dart';

import 'detail_screeen.dart';
class ContriesListScreen extends StatefulWidget {
   ContriesListScreen({super.key});

  @override
  State<ContriesListScreen> createState() => _ContriesListScreenState();
}

class _ContriesListScreenState extends State<ContriesListScreen> {
  TextEditingController searchController=TextEditingController();
  StatesServices statesServices=StatesServices();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),

              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                    if(!snapshot.hasData){
                      return ListView.builder(
                        itemCount:5 ,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                            child: Column(
                                children: [
                                  ListTile(
                                    title:Container(height: 10,width: 89,color: Colors.white,) ,
                                    subtitle:Container(height: 10,width: 89,color: Colors.white,) ,
                                    leading:Container(height: 50,width: 50,color: Colors.white,) ,

                                  )
                                ],
                              ),

                          );
                        },
                      );
                    }else{
                      return ListView.builder(
                        itemCount:snapshot.data!.length ,
                        itemBuilder: (context, index) {
                          String name=snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                       DetailsScreen(
                                         name: snapshot.data![index]['country'],
                                         images: snapshot.data![index]['countryInfo']['flag'],
                                         totalCases: snapshot.data![index]['cases'],
                                         totalRecoverd: snapshot.data![index]['todayRecovered'],
                                         totalDeaths: snapshot.data![index]['todayDeaths'],
                                         active:  snapshot.data![index]['active'],
                                         test: snapshot.data![index]['tests'],
                                         todayRecovered: snapshot.data![index]['todayRecovered'],
                                         critical: snapshot.data![index]['critical'],
                                       )
                                    ));
                                  } ,
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']) ,
                                    subtitle:Text(snapshot.data![index]['cases'].toString()) ,
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag'],)
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [

                                InkWell(
                                  onTap:() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        DetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          images: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecoverd: snapshot.data![index]['todayRecovered'],
                                          totalDeaths: snapshot.data![index]['todayDeaths'],
                                          active:  snapshot.data![index]['active'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          critical: snapshot.data![index]['critical'],
                                        )
                                    ));
                                  } ,

                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']) ,
                                    subtitle:Text(snapshot.data![index]['cases'].toString()) ,
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                          snapshot.data?[index]['countryInfo']['flag'],)
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          else{
                            return Container();
                          }

                        },);
                    }


                },)
            )
          ],
        ),
      ),
    );
  }
}
