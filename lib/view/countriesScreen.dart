import 'package:covid_test_api_app/Services/stateservices.dart';
import 'package:covid_test_api_app/view/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices services = StateServices();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {
                    
                  });
                },
                style: TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: 'Search With Countries',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintStyle: TextStyle(color: Colors.white), // Set hint text color to white
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set focused border color to white
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            Expanded(

                child: FutureBuilder(
                  future: services.fetchCountriesData(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return ListView.builder(
                        itemCount: 4,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [

                                  ListTile(
                                    title: Container(
                                      height: 10,
                                        width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle:Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                  ),


                                ],
                              ),
                            );

                          });
                    }
                    else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty){
                              return Column(
                                children: [

                                  InkWell(
                                    onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    critical: snapshot.data![index]['critical'],
                                    active: snapshot.data![index]['active'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    test: snapshot.data![index]['tests'],
                                    todayrecoverd: snapshot.data![index]['todayRecovered'],
                                    totalCase: snapshot.data![index]['cases'],
                                    totaldeaths: snapshot.data![index]['deaths'],
                                    totalrecovered: snapshot.data![index]['recovered'],
                                )));
                              },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'],style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                      subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                    ),
                                  ),


                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [

                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        critical: snapshot.data![index]['critical'],
                                        active: snapshot.data![index]['active'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        test: snapshot.data![index]['tests'],
                                        todayrecoverd: snapshot.data![index]['todayRecovered'],
                                        totalCase: snapshot.data![index]['cases'],
                                        totaldeaths: snapshot.data![index]['deaths'],
                                        totalrecovered: snapshot.data![index]['recovered'],
                                      )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'],style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                      subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                    ),
                                  ),


                                ],
                              );
                            }
                            else{
                              return Container();
                            }
                          });
                    }

                  },
                )),

          ],
        ),
      ),
    );
  }
}
