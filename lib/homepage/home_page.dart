import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gospel/homepage/drawer.dart';
import 'package:provider/provider.dart';
import 'package:gospel/provider/drawer_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  AnimationController _animationController;
  bool isMenu;

  PageController _pageController = PageController();
  Color left = Colors.black;
  Color right = Colors.white;

  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    isMenu=false;
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        drawerScreen(),
        homeScreen()
      ],
    );
  }

  void _handleOnPressed() {
    setState(() {
      isMenu = !isMenu;
      isMenu
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  Widget homeScreen(){
    final width = MediaQuery.of(context).size.width;
    return zoomAndSlideContent(
      Scaffold(
        backgroundColor: const Color(0xFF00ffa4),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Container(
            height: 60,
            child: Image.asset('assets/gospel_blue.png', fit: BoxFit.contain),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: const Color(0xff0a0548).withOpacity(0.6)
                  )
                ]
              ),
              child: IconButton(
                icon: Transform.translate(
                  offset: Offset(-1, -1),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                  ),
                ),
                onPressed: (){
                  _handleOnPressed();
                  Provider.of<MenuController>(context, listen: true).toggle();
                }
              )
            ),
          ),
          actions: [
            SizedBox(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: width*0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: const Color(0xff0a0548).withOpacity(0.6)
                    )
                  ]
                ),
                child: IconButton(
                  icon: Transform.translate(
                    offset: Offset(-1, -1),
                    child: Icon(
                    Icons.image,
                      size: 22,
                      color: Color(0xFF0a0548),
                    ),
                  ),
                  onPressed: (){}
                )
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Color(0xFF0a0548),
          onPressed: () {},
        ),
        body: Column(
          children: [
            _buildMenuBar(context),
            Expanded(
              flex: 2,
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) {
                  if (i == 0) {
                    setState(() {
                      right = Colors.white;
                      left = Colors.black;
                      // nullifyFields();
                    });
                  } else if (i == 1) {
                    setState(() {
                      right = Colors.black;
                      left = Colors.white;
                      // nullifyFields();
                    });
                  }
                },
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    // The login/ sign in screen
                    child: _buildHot(context),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    // the sign up screen
                    child: _buildFresh(context),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  Widget drawerScreen(){
    return Container(
      child: Scaffold(
        body: DrawerScreen(context),
      ),
    );
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;

    switch (Provider.of<MenuController>(context, listen: true).state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        scalePercent = scaleDownCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        scalePercent = scaleUpCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        break;
    }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius =
        16.0 * Provider.of<MenuController>(context, listen: true).percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
      return Container(
        width: 288,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xff0a0548),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        alignment: Alignment.center,
        // Using custom paint to create the UI
        child: CustomPaint(
          // Call to the UI
          painter: TabIndicationPainter(pageController: _pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    //OnPressed changing the previous focus
                    FocusScope.of(context).unfocus();
                    // Navigating to SignIn
                    _onHotButtonPress();
                  },
                  child: Text(
                    "Hot",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: left,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    //OnPressed changing the previous focus
                    FocusScope.of(context).unfocus();
                    // Navigating to SignUp
                    _onFreshButtonPress();
                  },
                  child: Text(
                    "Fresh",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: right,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

  void _onHotButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  //Animation while changing the screen
  void _onFreshButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  Widget _buildHot(BuildContext context) {
    return Column();
  }

  Widget _buildFresh(BuildContext context) {
    return Column();
  }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 20.0,
      this.radius = 15.0,
      this.dy = 20.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, Color(0xFFfbab66), 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
