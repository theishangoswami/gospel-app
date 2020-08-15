import 'package:flutter/material.dart';
import 'package:gospel/util/app_theme.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.green,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(AppTheme.blue),
        ),
      ),
    );
  }
}