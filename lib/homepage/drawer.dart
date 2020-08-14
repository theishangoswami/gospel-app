import 'package:flutter/material.dart';
import 'package:gospel/provider/drawer_controller.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DrawerScreen extends StatefulWidget {
  final BuildContext context;
  
  DrawerScreen(this.context);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

    List<MenuItem> options;

  @override
  void initState() {
    super.initState();
    options = [
    MenuItem(
      icon: Icons.search, 
      title: 'Search',
      onTap: (){}
    ),
    MenuItem(
      icon: Icons.info, 
      title: 'About Us',
      onTap: (){}
    ),
    MenuItem(
      icon: Icons.favorite, 
      title: 'Spread the Gospel',
      onTap: _share
    ),
    MenuItem(
      icon: Icons.code, 
      title: 'License',
      onTap: (){}
    ),
    MenuItem(
      icon: Icons.rate_review, 
      title: 'Rate Us',
      onTap: (){}
    ),
  ];
  }

  _share(){
    final RenderBox box = widget.context.findRenderObject();
    Share.share(
      'Checkout the Gospel App!',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Color(0xff0a0548),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.image
                  )
                ),
                Text(
                  'Tatiana',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Spacer(),
            Column(
              children: options.map((item) {
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onTap: item.onTap,
                );
              }).toList(),
            ),
            Spacer(),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Settings',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.headset_mic,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Support',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  Function onTap;

  MenuItem({this.icon, this.title, this.onTap});
}
