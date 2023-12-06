import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zelleclients/pages/landingPage.dart';
import 'package:zelleclients/pages/orders.dart';
import 'package:zelleclients/pages/products.dart';
import 'package:zelleclients/provider/provider1.dart';


class MainInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    Future<dynamic> getD()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Provider11.base=prefs.getString('base');
      Provider11.ck=prefs.getString('ck');
      Provider11.cs=prefs.getString('cs');
      Provider11.name=prefs.getString('name');
      Provider11.state=prefs.getBool('state');
      return Text("done");
    }
    return FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
 
                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
              }
            }
 
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
 
          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: getD(),
        );
    
  
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int _currentIndex = 0;
 late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MyTabbedPage(),
            OrdersList(),
            Products(),
          ],
        ),
      ),


      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xff1E1E1E),
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.dashboard_outlined),
            title: Text('Statistics'),
            activeColor: Colors.grey,
            
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.task_outlined),
            title: Text('Orders'),
            activeColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            title: Text(
              'Inventory',
            ),
            activeColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
         
        ],
      ),
    );
  }
}