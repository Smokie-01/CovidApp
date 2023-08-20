import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/view/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController countryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Scaffold().backgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: countryNameController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search countires here",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: StatsServices.getCountriesList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return CustomShimmer();
                  },
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (countryNameController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetaliedScreen(
                                              countryName: name,
                                              imageUrl: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              deaths: snapshot.data![index]
                                                  ['deaths'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['recovered'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                            )));
                              },
                              child: ListTile(
                                title: Text(name),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  height: 50,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(countryNameController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetaliedScreen(
                                              countryName: name,
                                              imageUrl: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              deaths: snapshot.data![index]
                                                  ['deaths'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['recovred'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                            )));
                              },
                              child: ListTile(
                                title: Text(name),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  height: 50,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            subtitle: Container(
              height: 10,
              width: 89,
              color: Colors.white,
            ),
            leading: Container(
              color: Colors.white,
              height: 50,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}
