import 'package:flutter/material.dart';

class CreateGospel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF00ffa4),
          title: Text(
            'Create Gospel',
            style: TextStyle(
              color: Color(0xFF0a0548),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Color(0xff0a0548),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Text(
                  "Rules to follow",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Text(
                  " • With great power comes great responsibilty. \n\n • Be polite and do not abuse other! \n\n • Zero tolerance policy on posting people's personal information \n\n • Only post relevant topics in gospel \n\n • Enjoy your freedom of expression and restrain inappropriate behavior \n",
                  style: TextStyle(
                    fontSize: 20.0,
                    // fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Center(
                  child: RaisedButton(
                      color: Color(0xff0a0548),
                      textColor: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Post Gospel",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.send),
                        ],
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                      onPressed: () => Navigator.pop(context)),
                ),
              ),
            ],
          ),
        ));
  }
}
