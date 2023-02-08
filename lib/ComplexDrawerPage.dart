import 'package:flutter/material.dart';

import 'ComplexDrawerMenu.dart';

int selectedIndex = -1; //don't set to 0
int currentCattegory = -1;

class ComplexDrawerPage extends StatefulWidget {
  const ComplexDrawerPage({Key? key}) : super(key: key);

  @override
  State<ComplexDrawerPage> createState() => _ComplexDrawerPageState();
}

class _ComplexDrawerPageState extends State<ComplexDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Color(0xffe3e9f7),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Dorm Gym",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color(0xffe3e9f7),
    );
  }
}

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  State<ComplexDrawer> createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    return Container(
      //width: width / 2,
      child: Row(
        children: [blackIconMenu(changeIndex), invisibleSubMenus()],
      ),
    );
  }

  void changeIndex() {
    setState(() {
      currentCattegory = selectedIndex;
    });
  }
}

Container blackIconMenu(VoidCallback changeIndex) {
  return Container(
      width: 100,
      color: Color(0xff11111d),
      child: ListView.builder(
          itemCount: cdms.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () {
                selectedIndex = index;
                changeIndex();
              },
              child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: Icon(
                    cdms[index].icon,
                    color: Colors.white,
                  )),
            );
          }));
}

Container invisibleSubMenus() {
  return Container(
    width: 150,
    color: Colors.pink,
    child: ListView.builder(
      itemCount: cdms.length,
      itemBuilder: (ctx, index) {
        CDM cdm = cdms[index];
        bool selected = currentCattegory == index;
        if (selected) {
          return subMenuWidget(cdm.title, cdm.submenus);
        }
        return invisibleSubMenuWidget();
      },
    ),
  );
}

Widget subMenuWidget(String title, List<String> submenus) {
  return Container(
    color: Color(0xff1d1b31),
    height: 100,
    child: ListView.builder(
      itemCount: submenus.length,
      itemBuilder: (ctx, index) {
        String subMenu = submenus[index];
        return Text(
          subMenu,
          style: TextStyle(color: Colors.blueGrey),
        );
      },
    ),
  );
}

Widget invisibleSubMenuWidget() {
  return Container(
    height: 45,
    color: Colors.green,
  );
}

List<CDM> cdms = [
  CDM(Icons.grid_view, "Dashboard", []),
  CDM(Icons.subscriptions, "Category",
      ["HTML & CSS", "Javascript", "PHP & MySQL"]),
  CDM(Icons.markunread_mailbox, "Posts", ["Add", "Edit", "Delete"]),
  CDM(Icons.pie_chart, "Analytics", []),
  CDM(Icons.trending_up, "Chart", []),
  CDM(Icons.power, "Plugins", ["Ad Blocker", "Everything Https", "Dark Mode"]),
  CDM(Icons.explore, "Explore", []),
  CDM(Icons.settings, "Setting", []),
];