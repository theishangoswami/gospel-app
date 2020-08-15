import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gospel/screen/homepage/home_page.dart';
import 'package:gospel/auth/sign_in.dart';
import 'package:gospel/util/fade_transition.dart';
import 'package:gospel/util/loader.dart';

var color1 = Color(0xFF0a0548);
var color2 = Color(0xff00ffa4);
var color3 = Color(0xFF0a0548);

final AuthService authService = AuthService();

List<String> image = [
  'assets/lightning.png',
  'assets/bubble.png',
  'assets/megaphone.png'
];

List<String> title = [
  "Share your views with College mates",
  'Chat and gossip anonymously!',
  'Spread the gospel!',
];

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  CarouselSlider carouselSlider;
  int carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    carouselSlider = CarouselSlider(
      viewportFraction: 1.0,
      enableInfiniteScroll: false,
      onPageChanged: (index) {
        setState(() {
          carouselIndex = index;
        });
      },
      height: MediaQuery.of(context).size.height,
      items: <Widget>[
        CarouselComponent(
          col1: color1,
          col2: color2,
          imgUrl: image[0],
          ttl: title[0],
        ),
        CarouselComponent(
          col1: color2,
          col2: color3,
          imgUrl: image[1],
          ttl: title[1],
        ),
        CarouselComponent(
          col1: color3,
          col2: color3,
          imgUrl: image[2],
          ttl: title[2],
        ),
      ],
    );

    return Scaffold(
      floatingActionButton: carouselIndex == 2
          ? Container()
          : IconButton(
              icon: Icon(
                Icons.chevron_right,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                carouselSlider.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              }),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          carouselSlider,
          carouselIndex == 2
              ? Positioned(
                  bottom: 50,
                  child: MaterialButton(
                    color: Color(0xFF00ffa4),
                    onPressed: () {
                      Navigator.of(context).push(FadeRoute(page: Loader()));
                      authService.signInWithGoogle(context).whenComplete(() {
                        Navigator.of(context).push(
                          FadeRoute(page: HomePage()),
                        );
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    child: Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: Color(0xFF0a0548),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: 80,
                  child: Row(
                    children: <Widget>[
                      Indicator(
                        carouselIndex: carouselIndex,
                        indicatorIndex: 0,
                      ),
                      Indicator(
                        carouselIndex: carouselIndex,
                        indicatorIndex: 1,
                      ),
                      Indicator(
                        carouselIndex: carouselIndex,
                        indicatorIndex: 2,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class CarouselComponent extends StatelessWidget {
  final col1, col2, imgUrl, ttl;

  CarouselComponent({this.col1, this.col2, this.imgUrl, this.ttl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 10),
      color: col2,
      child: Container(
        decoration: BoxDecoration(
          color: col1,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(180),
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 130,
            ),
            Image.asset(
              imgUrl,
              height: 300,
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 9,
              ),
              child: Text(
                ttl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final carouselIndex, indicatorIndex;

  Indicator({this.carouselIndex, this.indicatorIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: carouselIndex == indicatorIndex ? Colors.white : Colors.grey,
      ),
    );
  }
}
