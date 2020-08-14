import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00ffa4),
        title: Container(
          height: 60,
          alignment: Alignment.centerRight,
          child: Image.asset('assets/gospel_blue.png', fit: BoxFit.contain),
        ),
        leading: Icon(
          Icons.menu,
          size: 30,
          color: Color(0xFF0a0548),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xFF0a0548),
        onPressed: () {},
      ),
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
          height: 60,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //trending button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: MaterialButton(
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.whatshot,
                          size: 30,
                        ),
                        Text('Trending'),
                      ],
                    )),
              ),
              //New button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: MaterialButton(
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.message,
                          size: 30,
                        ),
                        Text('New'),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
