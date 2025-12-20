import 'package:go_router/go_router.dart';
import 'package:wavenadmin/persentation/cubit/auth_cubit.dart';
import 'package:wavenadmin/persentation/pages/photo_grapher_management_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/auth_listen.dart';
import 'package:wavenadmin/persentation/pages/admin_management_page.dart';
import 'package:wavenadmin/persentation/pages/client_page.dart';
import 'package:wavenadmin/persentation/pages/dashboard_page.dart';
import 'package:wavenadmin/persentation/pages/login_page.dart';
import 'package:wavenadmin/persentation/pages/mains_caffold.dart';
import 'package:wavenadmin/persentation/pages/pengaturan_page.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/pages/user_management_page.dart';

class Approuter {
  GoRouter myRouter(AuthCubit authCubit){
    return  GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: CubitListenable(authCubit),
    routes: [
      GoRoute(
        path: '/login',
        name: 'loginpage',
        builder: (context, state) => LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            Mainscaffold(navigationShellState: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const Dashboardpage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pengaturan',
                builder: (context, state) => const Pengaturan(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/client',
                builder: (context, state) => const ClientPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/schedule',
                builder: (context, state) => const SchedulePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/user',
                builder: (context, state) => const UserManagementpage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/adminManagement',
                builder: (context, state) => const AdminManagementPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/photographermanagement',
                builder: (context, state) => const PhotoGrapherManagementPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final unsafepath = ['/login'];
      if (authCubit.state is AuthSucces && unsafepath.contains(state.uri.path)) {
        return '/dashboard';
      }
      if (authCubit.state is! AuthSucces && !unsafepath.contains(state.uri.path) ) {
        return '/login';
      }
      return null;
    },
  );
  }
}
