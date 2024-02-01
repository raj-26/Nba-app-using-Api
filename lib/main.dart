import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/models.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NbaApp(),
    );
  }
}

class NbaApp extends StatefulWidget {
  const NbaApp({super.key});

  @override
  State<NbaApp> createState() => _NbaAppState();
}

// class _NbaAppState extends State<NbaApp> {
//
//   List<Team> teams = [];
//
//   // get teams
//   Future getTeams() async {
//     var response = await  http.get(Uri.https('balldontlie.io','api/v1/players'));
//     var jsonData = jsonDecode(response.body);
//
//     for (var eachTeam in jsonData['data']) {
//       final team = Team(
//         abbreviation : eachTeam['abbreviation'],
//         city: eachTeam['city'],
//       );
//       teams.add(team);
//     }
//     print(teams.length);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // getTeams();
//     return Scaffold(
//       backgroundColor: Colors.deepPurple[100],
//       body: FutureBuilder(
//         future: getTeams(),
//         builder: (context, snapshot) {
//
//           if (snapshot.connectionState == ConnectionState.done) {
//             return ListView.builder(
//               itemCount: teams.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(teams[index].abbreviation),
//                   );
//                 }
//             );
//           }
//           else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//

class _NbaAppState extends State<NbaApp> {
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
    // Call getTeams in initState to fetch data when the widget is created
    getTeams();
  }

  // get teams
  Future<void> getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }
    // Print the length of teams for debugging
    print(teams.length);
    // Force a rebuild after data is fetched
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
            'Nba App',
        style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[100],
      body: FutureBuilder(
        // Use Future.value to simulate completion of the Future
        future: Future.value(teams),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.grey[500],
                  // ),
                  child: ListTile(
                    title: Text(teams[index].abbreviation),
                    subtitle: Text(teams[index].city),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
