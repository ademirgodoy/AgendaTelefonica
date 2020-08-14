import 'package:flutter/material.dart';
import 'package:agendatelefonica/util/dbhelper.dart';
import 'package:agendatelefonica/model/agenda.dart';
import 'package:agendatelefonica/screens/agendaPrincipal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Telefonica',
      home: new AgendaTelefonica(),
    );
  }
}

class AgendaTelefonica extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AgendaTelefonicaState();
}

class AgendaTelefonicaState extends State<AgendaTelefonica> {
  @override
  Widget build(BuildContext formContext) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda Telefonica"),
      ),
      body: AgendaPrincipal(),
    );
  }
}