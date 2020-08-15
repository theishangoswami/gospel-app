import 'package:flutter/material.dart';

class ViewGospel extends StatefulWidget {
  @override
  _ViewGospelState createState() => _ViewGospelState();
}

class _ViewGospelState extends State<ViewGospel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(
          Icons.arrow_back_ios
        ), onPressed: ()=> Navigator.pop(context))
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}