import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/persentation/widget/side_navigation.dart';

class Mainscaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShellState;
  const Mainscaffold({super.key, required this.navigationShellState});

  @override
  Widget build(BuildContext context) {
    final iswidth = MediaQuery.of(context).size.width > 900;
    
    // Bottom nav items mapping: branch index
    final bottomNavItems = [
      {'index': 0, 'label': 'Dashboard', 'icon': Icons.dashboard},
      {'index': 2, 'label': 'Client', 'icon': Icons.people},
      {'index': 3, 'label': 'Schedule', 'icon': Icons.calendar_today},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Waven"),
      ),
      drawer: iswidth
          ? null
          : MainScaffoldDrawer(statefulNavigationShell: navigationShellState),
      body: SafeArea(
        child: Row(
          children: [
            iswidth
                ? Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black,
                      child: SideNavigation(
                        statefulNavigationShell: navigationShellState,
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.black,
                child: navigationShellState,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: !iswidth
          ? BottomNavigationBar(
              currentIndex: _getCurrentIndex(navigationShellState.currentIndex),
              onTap: (index) {
                navigationShellState.goBranch(
                  bottomNavItems[index]['index'] as int,
                );
              },
              items: bottomNavItems
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(item['icon'] as IconData),
                        label: item['label'] as String,
                      ))
                  .toList(),
              backgroundColor: Colors.black87,
              selectedItemColor: MyColor.hijauaccent,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
            )
          : null,
    );
  }

  int _getCurrentIndex(int branchIndex) {
    // Map branch index to bottom nav index
    switch (branchIndex) {
      case 0:
        return 0; // Dashboard
      case 2:
        return 1; // Client
      case 3:
        return 2; // Schedule
      default:
        return 0;
    }
  }
}

