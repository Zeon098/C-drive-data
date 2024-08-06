import 'package:flutter/material.dart';


void main() => runApp(const MaterialApp(
  home: LoginScreen3(),
));


class LoginScreen3 extends StatefulWidget {
  const LoginScreen3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreen3State createState() => _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {

  //The code is commented because instead of manual scrolling with animation,
  //Now PageView is being used

  /*double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double dragDirection; // -1 for left, +1 for right

  AnimationController controller_minus1To0;
  AnimationController controller_0To1;
  CurvedAnimation anim_minus1To0;
  CurvedAnimation anim_0To1;

  final numCards = 3;

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    if (dragDistance > 0) {
      dragDirection = 1.0;
    } else {
      dragDirection = -1.0;
    }
    final singleCardDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent =
          (startDragPercentScroll + (-singleCardDragPercent / numCards))
              .clamp(0.0 - (1 / numCards), (1 / numCards));
      print(scrollPercent);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (scrollPercent > 0.1666) {
      print("FIRST CASE");
      controller_0To1.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == -1.0) {
      print("SECOND CASE");
      controller_0To1.reverse(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == 1.0) {
      print("THIRD CASE");
      controller_minus1To0.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < -0.1666) {
      print("LAST CASE");
      controller_minus1To0.reverse(from: scrollPercent * numCards);
    }

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }
  */

  @override
  void initState() {
    super.initState();

    //The code is commented because instead of manual scrolling with animation,
    //Now PageView is being used

    /*
    controller_minus1To0 =   AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: -1.0,
      upperBound: 0.0,
    );
    controller_0To1 =   AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    anim_minus1To0 =   CurvedAnimation(
      parent: controller_minus1To0,
      curve: Interval(0.10, 0.90, curve: Curves.bounceInOut),
    );
    anim_0To1 =   CurvedAnimation(
      parent: controller_0To1,
      curve: Interval(0.10, 0.90, curve: Curves.bounceInOut),
    );

    anim_0To1.addListener(() {
      scrollPercent = controller_0To1.value / numCards;
//      print(scrollPercent);
      setState(() {});
    });

    anim_minus1To0.addListener(() {
      scrollPercent = controller_minus1To0.value / numCards;
//      print(scrollPercent);
      setState(() {});
    });
    */
  }

  // ignore: non_constant_identifier_names
  Widget HomePage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: const AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 250.0),
            child:const Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20.0),
            child:  const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Awesome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child:   Row(
              children: <Widget>[
                  Expanded(
                  child:   OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.white),
                      ),
                    ),
                    
                    onPressed: () => gotoSignup(),
                    child:   Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child:   const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child:   Row(
              children: <Widget>[
                  Expanded(
                  child:   TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => gotoLogin(),
                    child:   Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: const  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LoginPage() {
    return   Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter:   ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: const AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child:   Column(
        children: <Widget>[
          Container(
            padding:const EdgeInsets.all(100.0),
            child:const Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.redAccent,
                size: 50.0,
              ),
            ),
          ),
           const Row(
            children: <Widget>[
                Expanded(
                child:   Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child:   Text(
                    "EMAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration:  const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child:   const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'samarthagarwal@live.com',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 24.0,
          ),
            const Row(
            children: <Widget>[
                Expanded(
                child:   Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child:   Text(
                    "PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child:   const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 24.0,
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child:   TextButton(
                  child: const  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            alignment: Alignment.center,
            child:   Row(
              children: <Widget>[
                  Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () => {},
                    child:   Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child:   const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                  Expanded(
                  child:   Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
                const Text(
                  "OR CONNECT WITH",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  Expanded(
                  child:   Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
              ],
            ),
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            child:   Row(
              children: <Widget>[
                  Expanded(
                  child:   Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    alignment: Alignment.center,
                    child:   Row(
                      children: <Widget>[
                          Expanded(
                          child:   TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: const Color(0Xff3B5998),
                            ),

                            onPressed: () => {},
                            child:   Container(
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Expanded(
                                    child:   Padding(
                                      padding:const EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                        ),
                                      child: TextButton(
                                        onPressed: ()=>{},
                                        
                                        child:   const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              IconData(0xea90,
                                                  fontFamily: 'icomoon'),
                                              color: Colors.white,
                                              size: 15.0,
                                            ),
                                            Text(
                                              "FACEBOOK",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  Expanded(
                  child:   Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    alignment: Alignment.center,
                    child:   Row(
                      children: <Widget>[
                          Expanded(
                          child:   TextButton(
                            style: TextButton.styleFrom(
                            shape:   RoundedRectangleBorder(
                              borderRadius:   BorderRadius.circular(30.0),
                            ),
                            backgroundColor: const Color(0Xffdb3236),
                          
                            ),
                            onPressed: () => {},
                            child:   Container(
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Expanded(
                                    child:   Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                        ),
                                      child: TextButton(
                                        onPressed: ()=>{},
                                        
                                        child:   const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              IconData(0xea88,
                                                  fontFamily: 'icomoon'),
                                              color: Colors.white,
                                              size: 15.0,
                                            ),
                                            Text(
                                              "GOOGLE",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget SignupPage() {
    return SingleChildScrollView(
      child:   Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter:   ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: const AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:   Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(100.0),
              child: const Center(
                child: Icon(
                  Icons.headset_mic,
                  color: Colors.redAccent,
                  size: 50.0,
                ),
              ),
            ),
              const Row(
              children: <Widget>[
                  Expanded(
                  child:   Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child:   Text(
                      "EMAIL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
              Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child:   const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'samarthagarwal@live.com',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 24.0,
            ),

              const Row(
              children: <Widget>[
                  Expanded(
                  child:   Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child:   Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
              Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child:   const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 24.0,
            ),
              const Row(
              children: <Widget>[
                  Expanded(
                  child:   Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child:   Text(
                      "CONFIRM PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
              Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child:   const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 24.0,
            ),
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child:   TextButton(
                    child:   const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
              Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              alignment: Alignment.center,
              child:   Row(
                children: <Widget>[
                    Expanded(
                    child:   TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                      
                      onPressed: () => {},
                      child:   Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child:   const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Expanded(
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  final PageController _controller =   PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
//      child:   GestureDetector(
//        onHorizontalDragStart: _onHorizontalDragStart,
//        onHorizontalDragUpdate: _onHorizontalDragUpdate,
//        onHorizontalDragEnd: _onHorizontalDragEnd,
//        behavior: HitTestBehavior.translucent,
//        child: Stack(
//          children: <Widget>[
//              FractionalTranslation(
//              translation: Offset(-1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: SignupPage(),
//            ),
//              FractionalTranslation(
//              translation: Offset(0 - (scrollPercent / (1 / numCards)), 0.0),
//              child: HomePage(),
//            ),
//              FractionalTranslation(
//              translation: Offset(1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: LoginPage(),
//            ),
//          ],
//        ),
//      ),
        child: PageView(
          controller: _controller,
          physics:   const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
        ));
  }
}