import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenhome/main.dart';
import 'package:greenhome/widget/appBar.dart';

const String startMsg =
    'Start saving on your electricity bill today! \n\nLog your appliances and usage habits on our smart platform, and receive personalized insights to optimize your energy consumption.';

class Dashboard extends StatefulWidget {
  final bool isNewUser;
  const Dashboard({super.key, required this.isNewUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showNewUserMsg = true;

  @override
  void initState() {
    showNewUserMsg = widget.isNewUser;
    super.initState();
  }

  Widget gettingStartedMsg() {
    return Center(
      child: Opacity(
        opacity: 0.85,
        child: Container(
          width: 281,
          height: 317,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFDFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Getting Started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  startMsg,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showNewUserMsg = false;
                  });
                },
                child: const Text('Start'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTemplate({double width = 200}) {
    return Opacity(
      opacity: 0.85,
      child: Container(
        height: 150,
        width: width,
        decoration: ShapeDecoration(
          color: const Color(0xFFFFFDFD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.home,
              size: width / 2.5,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                Text('Value'),
                Text('Conversion'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget deviceCards(screenWidth, screenHeight) {
    // return Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       cardTemplate(),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           cardTemplate(width: screenWidth / 2.5),
    //           cardTemplate(width: screenWidth / 2.5),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    List<String> deviceList = ['a', 'b', 'c', 'd', 'e']; // Your device list

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: deviceList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: screenWidth / (screenHeight / 4),
        crossAxisCount: 2, // Number of items in a row
        crossAxisSpacing: 10, // Spacing between items horizontally
        mainAxisSpacing: 10, // Spacing between items vertically
      ),
      itemBuilder: (ctx, index) {
        return cardTemplate(width: screenWidth / 2.5);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const GreenHomeAppBar(
          title: appName,
          isTransparent: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/HomeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: showNewUserMsg
              ? gettingStartedMsg()
              : Padding(
                  padding:
                      EdgeInsets.only(top: AppBar().preferredSize.height * 2),
                  child: Column(
                    children: [
                      Center(
                        child: cardTemplate(width: 300),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: screenHeight / 2,
                          child: deviceCards(screenWidth, screenHeight),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
