import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

StatefulWidget home(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 50,
                color: const Color(0x00f9fcfe),
              ),
              const Image(
                image: AssetImage('asset/images/SP_MainTop.png'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 249, 252, 254),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the registration screen
                      Navigator.of(context).pushNamed('/newUserReg');
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                      ),
                      margin: const EdgeInsets.only(top: 20),
                      child: const Center(
                        child: Text(
                          'Welcome to GreenHome',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
              const Image(
                image: AssetImage('asset/images/SP_MainBottom.png'),
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
