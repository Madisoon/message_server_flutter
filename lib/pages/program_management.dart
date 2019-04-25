import 'package:flutter/material.dart';

class ProgramManagement extends StatefulWidget {
  ProgramManagement({Key key}) : super(key: key);

  @override
  ProgramManagementState createState() => ProgramManagementState();
}

class ProgramManagementState extends State<ProgramManagement> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('方案'),
        actions: <Widget>[],
      ),
      body: Container(),
    );
  }
}
