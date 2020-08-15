import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gospel/model/post.dart';
import 'package:gospel/model/user_data.dart';
import 'package:gospel/services/database_service.dart';
import 'package:gospel/util/app_theme.dart';
import 'package:provider/provider.dart';

class CreateGospel extends StatefulWidget {
  @override
  _CreateGospelState createState() => _CreateGospelState();
}

class _CreateGospelState extends State<CreateGospel> {
  TextEditingController _textEditingController;
  bool _isLoading;
  List rules = [];

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _textEditingController = TextEditingController();
    print(Provider.of<UserData>(context, listen: false).currentUserId);
    rules = [
      'With great power comes great responsibilty.',
      'Be polite and do not abuse other!',
      'Zero tolerance policy on posting people\'s personal information',
      'Only post relevant topics in gospel',
      'Enjoy your freedom of expression and restrain inappropriate behavior',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: AppTheme.green,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'CREATE GOSPEL',
              style: TextStyle(color: AppTheme.blue, letterSpacing: 1),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30.0,
              color: AppTheme.blue,
            ),
          ),
          body: Container(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                    height: height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppTheme.blue.withOpacity(0.8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: _textEditingController,
                        maxLines: 10,
                        maxLength: 180,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Write the title here',
                          labelStyle: TextStyle(color: Color(0xff00ffa4)),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          helperStyle:
                              TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                  child: Text(
                    "RULES TO FOLLOW",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.blue,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < rules.length; i++)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.check_circle,
                                    size: 17, color: AppTheme.blue),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Expanded(
                                  child: Text(
                                    rules[i],
                                    style: TextStyle(
                                        fontSize: 15, color: AppTheme.blue),
                                  ),
                                )
                              ],
                            ),
                          ),
                        SizedBox(
                          height: height * 0.09,
                        ),
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                              width: height * 0.08,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: AppTheme.blue, shape: BoxShape.circle),
                              child: _isLoading
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                AppTheme.green),
                                      ),
                                    )
                                  : Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Colors.white,
                                    )),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          'POST',
                          style: TextStyle(fontSize: 16, color: AppTheme.blue),
                        ),
                      ],
                    )),
              ],
            ),
          )),
    );
  }

  _submit() async {
    print("Inside submit");
    if (_textEditingController.text.length > 0) {
      setState(() {
        _isLoading = true;
      });

      // Create post
      Post post = Post(
        title: _textEditingController.text,
        op: 'Name',
        likes: 0,
        opId: Provider.of<UserData>(context, listen: false).currentUserId,
        timestamp: Timestamp.fromDate(DateTime.now()),
      );
      DatabaseService.createPost(post);

      // Reset data
      _textEditingController.clear();
      Future.delayed(Duration(seconds: 2)).then((value) {
        setState(() {
          _textEditingController.text = '';
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    }
  }
}
