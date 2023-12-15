import 'package:covid_test_api_app/view/tracker_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;

  int totalCase, active, totaldeaths, totalrecovered, critical, test, todayrecoverd;

  DetailScreen({
  required this.name,
  required this.critical,
    required this.active,
    required this.image,
    required this.test,
    required this.todayrecoverd,
    required this.totalCase,
    required this.totaldeaths,
    required this.totalrecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    color: Colors.grey.shade800,
                    child: Column(
                      children: [
                        ReuseableRow(value: widget.totalCase.toString(), title: 'Total Cases'),
                        ReuseableRow(value: widget.totalrecovered.toString(), title: 'Total Recovered'),
                        ReuseableRow(value: widget.totaldeaths.toString(), title: 'Total Deaths'),
                        ReuseableRow(value: widget.critical.toString(), title: 'Critical'),
                        ReuseableRow(value: widget.todayrecoverd.toString(), title: 'Today Recovered'),
                        ReuseableRow(value: widget.test.toString(), title: 'Total Tests'),

                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  radius: 50,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
