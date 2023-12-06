import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/pages/subpages/month.dart';
import 'package:zelleclients/pages/subpages/today.dart';
import 'package:zelleclients/pages/subpages/week.dart';
import 'package:zelleclients/pages/subpages/year.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import '../utils/forgotLink.dart';

import 'package:flutter/material.dart';

import 'login.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
     Future<void> saveUserLoggedInState(bool isLoggedIn) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', isLoggedIn);
    }
     void logoutUser() async {
          try {
            await FirebaseAuth.instance.signOut();
            // Save the user's authentication state
            await saveUserLoggedInState(false);
             Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
          } on FirebaseAuthException catch (e) {
            print('Failed to sign out: $e');
          }
        }
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Color(0xff1B1B1B),
          actions: [
              ElevatedButton(
  onPressed: () {
    logoutUser();
  },
  child: Image.asset("assets/off.png",height: 30.h,width: 30.w,),
  style: ElevatedButton.styleFrom(
    shape: CircleBorder(),
    padding: EdgeInsets.all(2.0),
    backgroundColor: Colors.transparent
  ),
),

          ],
          title:  Text('${Provider11.name.toString()}'),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicator: UnderlineTabIndicator(
                // color for indicator (underline)
                borderSide: BorderSide(color: Color(0xffb929be))),
            labelColor: Color(0xffb929be),
            tabs: const <Tab>[
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Center(
                      child: Text(
                    'TODAY',
                  )),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Center(
                      child: Text(
                    'THIS WEEK',
                  )),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Center(
                      child: Text(
                    'THIS MONTH',
                  )),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Center(child: Text('THIS YEAR')),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(120.h),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          TodayReport(),
          WeekReport(),
          MonthReport(),
          YearReport(),
        ],
      ),
    );
  }
}
