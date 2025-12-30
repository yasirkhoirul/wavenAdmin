import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wavenadmin/persentation/widget/side_navigation.dart';

class Mainscaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShellState;
  const Mainscaffold({super.key, required this.navigationShellState});

  @override
  Widget build(BuildContext context) {
    final iswidth = MediaQuery.of(context).size.width > 900;
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
    );
  }  
}

