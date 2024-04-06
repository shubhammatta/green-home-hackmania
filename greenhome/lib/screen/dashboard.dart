import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenhome/main.dart';
import 'package:greenhome/screen/scan.dart';
import 'package:greenhome/screen/selectHome.dart';
import 'package:greenhome/widget/anomalyGraphWidget.dart';
import 'package:greenhome/widget/appBar.dart';
import 'package:greenhome/widget/graphWidget.dart';

const String startMsg =
    'Start saving on your electricity bill today! \n\nLog your appliances and usage habits on our smart platform, and receive personalized insights to optimize your energy consumption.';

class Dashboard extends StatefulWidget {
  final String? homeType;
  final bool isNewUser;
  const Dashboard({super.key, this.homeType, required this.isNewUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showNewUserMsg = true;

  @override
  void initState() {
    showNewUserMsg = widget.isNewUser;
    debugPrint(widget.homeType.toString());
    widget.homeType != null ? showNewUserMsg = false : '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                    showNewUserMsg
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectHomeType(),
                            ),
                          )
                        : '';
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

  Widget cardTemplate(
      {required String title, double width = 200, isNew = false}) {
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
            SizedBox(
              width: width - (width / 2.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: isNew
                    ? [
                        Text(title),
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ScanAppliance(),
                              ),
                            );
                            print('Result from ScanPage: $result');
                          },
                          icon: const Icon(
                            Icons.add_circle,
                          ),
                        )
                      ]
                    : [
                        // if text is large then line break
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const Text('Value'),
                        const Text('Conversion'),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deviceCards(screenWidth, screenHeight) {
    List<Map<String, dynamic>> devices = [
      {'name': 'Aircon', 'status': true, 'hours': 8},
      {'name': 'Water Heater', 'status': true, 'hours': 1},
      {'name': 'Refrigerator', 'status': true, 'hours': 24},
      {'name': 'Washing machine', 'status': true, 'hours': 0.5},
      {'name': 'Computer', 'status': true, 'hours': 10},
      {'name': 'Lighting', 'status': true, 'hours': 6},
    ];
    List<String> deviceList = [
      'Aircon',
      'Water Heater',
      'Refrigerator',
      'Washing machine',
      'Computer',
      'Lighting'
    ]; // device list
    List<bool> deviceStatus = [true, true, true, true, true];
    List<num> deviceHrs = [8, 1, 24, 0.5, 10, 6];

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
        if (index == deviceList.length - 1) {
          return cardTemplate(
            title: 'Add Device',
            width: screenWidth / 2.5,
            isNew: true,
          );
        }
        return cardTemplate(
          title: devices[index]['name'],
          width: screenWidth / 2.5,
          isNew: devices[index]['status'],
        );
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
                        child: cardTemplate(title: 'My Home', width: 300),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: screenHeight / 2,
                        child: PageView(
                          children: <Widget>[
                            SingleChildScrollView(
                              child: SizedBox(
                                height: screenHeight / 2,
                                child: deviceCards(screenWidth, screenHeight),
                              ),
                            ),
                            const Center(
                              child: GraphWidget(
                                  userId: 1234), // To Add Graph Widget
                            ),
                            const Center(
                              child: GraphAnomalyWidget(userId: 1234), // To Add Graph Widget
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
