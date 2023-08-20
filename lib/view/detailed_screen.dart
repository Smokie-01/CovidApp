import 'package:covid_app/view/home_screen.dart';
import 'package:flutter/material.dart';

class DetaliedScreen extends StatefulWidget {
  final String countryName;
  final String imageUrl;
  final int totalCases, todayRecovered, deaths;
  DetaliedScreen(
      {required this.countryName,
      required this.imageUrl,
      required this.totalCases,
      required this.todayRecovered,
      required this.deaths});

  @override
  State<DetaliedScreen> createState() => _DetaliedScreenState();
}

class _DetaliedScreenState extends State<DetaliedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.09),
                child: Card(
                  child: Column(
                  children: [
                    ReusableRow(title: "Country Name", value: widget.countryName),
                     ReusableRow(title: "Total Cases", value: widget.totalCases.toString()),
                      ReusableRow(title: "Total deaths", value: widget.deaths.toString()),
                       ReusableRow(title: "Total Recovered", value: widget.todayRecovered.toString())
                  ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.imageUrl),
              )
            ],
          )
        ]),
      ),
    );
  }
}
