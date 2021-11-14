import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImageSlider extends StatefulWidget {
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers.addAll([
      AnimationController(vsync: this),
      AnimationController(vsync: this),
      AnimationController(vsync: this)
    ]);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 10),
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              _controllers[index].reset();
              _controllers[index].forward();
            }),
        items: getImageSliders(_controllers, context),
      ),
    );
  }
}

List<Widget> getImageSliders(
    List<AnimationController> controllers, BuildContext context) {
  return imgList.map((item) {
    late String boardMessage;
    late LinearGradient linearGradient;
    late AnimationController controller;
    late String asset;
    if (imgList.indexOf(item) == 1) {
      controller = controllers[1];
      asset = 'assets/lottie/appointment.json';
      linearGradient = LinearGradient(
        colors: [
          Color(0xFf56ab2f),
          Color(0xFfa8e063),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
      boardMessage =
          'Employees who are yet to be vaccinated are adviced to book appointments';
    }
    if (imgList.indexOf(item) == 0) {
      controller = controllers[0];
      asset = 'assets/lottie/celebration.json';
      linearGradient = LinearGradient(
        colors: [
          Color(0xFfeb3349),
          Color(0xFff45c43),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
      boardMessage =
          'End year of party venue will be announced in the coming weeks';
    }
    if (imgList.indexOf(item) == 2) {
      controller = controllers[2];
      asset = 'assets/lottie/donate.json';
      linearGradient = LinearGradient(
        colors: [
          Color(0xFf42275a),
          Color(0xFf734b6d),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
      boardMessage =
          'Kudos to the whole team for contributing generously towards feed a child campaign';
    }
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        margin: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  boardMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(
                asset,
                controller: controller,
                onLoaded: (composition) {
                  controller
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }).toList();
}

final List<String> imgList = ['1', '2', '3'];
