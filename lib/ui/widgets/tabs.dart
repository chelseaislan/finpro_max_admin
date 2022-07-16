// @dart=2.9
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/ui/pages/tabbed_pages/home_page.dart';
import 'package:finpro_max_admin/ui/pages/tabbed_pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomeTabs extends StatelessWidget {
  final adminId;
  int selectedPage;
  HomeTabs({this.adminId, this.selectedPage});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(adminId: adminId),
      ProfilePage(adminId: adminId),
    ];
    return DefaultTabController(
      initialIndex: selectedPage,
      animationDuration: Duration.zero,
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: pages,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: menu(),
      ),
    );
  }

  Widget menu() {
    return Container(
      decoration: BoxDecoration(
        color: primary1,
        border: Border.all(color: white),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: TabBar(
        indicatorColor: gold,
        labelColor: gold,
        unselectedLabelColor: white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(5.0),
        tabs: const [
          Tab(
            icon: Icon(Icons.home_rounded, size: 30),
            text: "Verify Users",
          ),
          Tab(
            icon: Icon(Icons.person_rounded, size: 30),
            text: "Admin Profile",
          ),
        ],
      ),
    );
  }
}
