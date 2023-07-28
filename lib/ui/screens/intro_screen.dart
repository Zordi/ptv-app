import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import '/common/apipath.dart';
import '/common/route_paths.dart';
import '/providers/app_config.dart';
import 'package:provider/provider.dart';
import 'login_home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  Function? goToTab;
  bool isLoading = false;
  int currentIndex = 0;

  get _controller => PageController();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final blocks = context.read<AppConfig>().slides;
      List.generate(blocks.length, (int i) {
        return slides.add(
          new Slide(
            title: "${blocks[i].heading}",
            styleTitle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoMono'),
            description: "${blocks[i].detail}",
            styleDescription: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontFamily: 'Raleway'),
            pathImage: "${APIData.landingPageImageUri}${blocks[i].image}",
          ),
        );
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  //  WillPopScope to handle back press.
  Future<bool?> onWillPopS() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return SystemNavigator.pop() as Future<bool?>;
  }

  //  After done pressed on intro slider
  void onDonePress() {
    // Back to the first tab
    Navigator.pushNamed(context, RoutePaths.loginHome);
  }

  //  Counting index and changing UI page dynamically.
  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    setState(() {
      currentIndex = index;
    });
  }

  //  Next button
  Widget renderNextBtn() {
    final lastIndex = slides.length - 1;
    final isLastSlide = currentIndex == lastIndex;

    return isLastSlide
        ? ElevatedButton(
      onPressed: onDonePress,
      child: Text('Login'),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    )
        : Icon(
      Icons.navigate_next,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget renderContinueBtn() {
    return ElevatedButton(
      onPressed: onDonePress,
      child: Text('Continue'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent[700],
      ),
    );
  }

  //  Done button or last page of intro slider
  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Theme.of(context).primaryColor,
    );
  }

  //  Skip button to go directly to the last page of intro slider
  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Theme.of(context).primaryColor,
    );
  }

  //  Custom tabs
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  child: Image.network(
                    currentSlide.pathImage!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 30.0),
                Text(
                  currentSlide.title!,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    currentSlide.description!,
                    style: currentSlide.styleDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  //  Intro slider widget
  Widget introSlider() {
    return Stack(
      children: [
        Container(
          color: Colors.black, // Sample background color
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60.0,
                      width: 200.0,
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: SmoothPageIndicator(
                        controller: _controller, // Provide your own controller
                        count: slides.length,
                        effect: ScrollingDotsEffect(
                          activeDotColor: Colors.indigoAccent,
                          dotColor: Colors.grey,
                          dotHeight: 6.0,
                          dotWidth: 6.0,
                          spacing: 4.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onDonePress,
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: IntroSlider(
                    slides: slides,
                    renderNextBtn: renderNextBtn(),
                    renderDoneBtn: renderDoneBtn(),
                    renderSkipBtn: renderSkipBtn(),
                    listCustomTabs: renderListCustomTabs(),
                    backgroundColorAllSlides: Colors.black,
                    onTabChangeCompleted: onTabChangeCompleted,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: renderContinueBtn(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: isLoading == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : introSlider(),
      ),
      onWillPop: onWillPopS as Future<bool> Function()?,
    );
  }
}
