import 'package:flutter/material.dart';

/// 帮助与反馈页面
class HelpAndFeedbackPage extends StatefulWidget {
  HelpAndFeedbackPage({Key key}) : super(key: key);

  @override
  HelpAndFeedbackPageState createState() => HelpAndFeedbackPageState();
}

class HelpAndFeedbackPageState extends State<HelpAndFeedbackPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('帮助与反馈'),
      ),
      body: new Text('帮助与反馈'),
    );
  }
}
