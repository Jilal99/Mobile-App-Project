import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    Center(child: Text("Home", style: TextStyle(color: Colors.black))),
    Center(child: Text("Search", style: TextStyle(color: Colors.black))),
    Center(child: Text("Profile", style: TextStyle(color: Colors.black))),
    Center(child: Text("Notification", style: TextStyle(color: Colors.black))),
    Center(child: Text("Add item", style: TextStyle(color: Colors.black))),
  ];

  int currentPage = 0;

  setPage(index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME SCREEN', style: TextStyle(fontSize: 18)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseService().userLogout(context);
            },
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
            ),
            tooltip: 'LOGOUT',
          ),
        ],
      ),
      body: tabs[currentPage],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade400,
        onPressed: () => setPage(4),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade900,
          shape: CircularNotchedRectangle(),
          child: Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: currentPage == 0 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => setPage(0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: currentPage == 0 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => setPage(1),
                  ),
                  SizedBox.shrink(),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: currentPage == 0 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => setPage(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: currentPage == 0 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => setPage(3),
                  )
                ],
              ))),
    );
  }
}
