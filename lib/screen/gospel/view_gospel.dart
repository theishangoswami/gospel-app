import 'package:flutter/material.dart';
import 'package:gospel/model/post.dart';
import 'package:gospel/util/app_theme.dart';

class ViewGospel extends StatefulWidget {
  final Post post;
  ViewGospel({this.post});
  @override
  _ViewGospelState createState() => _ViewGospelState();
}

class _ViewGospelState extends State<ViewGospel> {

  TextEditingController _textEditingController;
  List comments = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.green,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height*0.05,),
                      Center(
                        child: Text(
                          widget.post.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      Text(
                        'Posted by: '+widget.post.op,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      Container(
                        height: height*0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppTheme.blue.withOpacity(0.8)
                        ),
                        child: TextFormField(
                          controller: _textEditingController,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.green,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(0, 3),
                                  blurRadius: 5
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Text(
                                'POST',
                                style: TextStyle(
                                  color: AppTheme.blue,
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios
              ), 
              onPressed: ()=> Navigator.pop(context)
            )
          ],
        ),
      ),
    );
  }
}