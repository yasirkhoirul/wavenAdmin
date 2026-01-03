import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/deep_link_handler.dart';
import 'package:wavenadmin/persentation/cubit/auth_cubit.dart';
import 'package:wavenadmin/persentation/pages/addon_reference_page.dart';
import 'package:wavenadmin/persentation/pages/fotografer_reference_page.dart';
import 'package:wavenadmin/persentation/pages/package_reference_page.dart';
import 'package:wavenadmin/persentation/pages/payment_result_page.dart';
import 'package:wavenadmin/persentation/pages/pengaturan_page.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/pages/universitas_reference_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/auth_listen.dart';
import 'package:wavenadmin/persentation/pages/admin_management_page.dart';
import 'package:wavenadmin/persentation/pages/client_page.dart';
import 'package:wavenadmin/persentation/pages/dashboard_page.dart';
import 'package:wavenadmin/persentation/pages/login_page.dart';
import 'package:wavenadmin/persentation/pages/mains_caffold.dart';
import 'package:wavenadmin/persentation/pages/filemover_page.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/pages/user_management_page.dart';

class Approuter {
  GoRouter myRouter(AuthCubit authCubit) {
    return GoRouter(
      initialLocation: '/dashboard',
      refreshListenable: CubitListenable(authCubit),
      routes: [
        // Payment callback route - handles deep link from payment gateway
        GoRoute(
          path: '/',
          name: 'payment-result',
          redirect: (context, state) {
            // Extract payment parameters from deep link
            final params = state.uri.queryParameters;
            final orderId = params['order_id'];
            final status = params['transaction_status'];
            
            Logger().d('Payment callback received - Order: $orderId, Status: $status');
            
            // Trigger deep link handler callback
            if (orderId != null && status != null) {
              DeepLinkHandler().onPaymentResult?.call(
                orderId,
                status,
                params,
              );
            }
            
            // Redirect to dashboard after handling callback
            return '/client';
          },
        ),
        GoRoute(
          path: '/payment/result',
          name: 'paymentresult',
          builder: (context, state) {
            final orderId = state.uri.queryParameters['order_id'];
            return PaymentResultPage(orderId);
          },
        ),
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
                  builder: (context, state) =>
                      const PhotoGrapherManagementPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/universitas',
                  builder: (context, state) => const UniversitasReferencePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/package',
                  builder: (context, state) => const PackageReferencePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/fotograferReferensi',
                  builder: (context, state) => const FotograferReferencePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/addonsReferensi',
                  builder: (context, state) => const AddonReferencePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/pengaturanPage',
                  builder: (context, state) => const PengaturanPage(),
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final unsafepath = ['/login'];
        if (authCubit.state is AuthSucces &&
            unsafepath.contains(state.uri.path)) {
          return '/dashboard';
        }
        if (authCubit.state is! AuthSucces &&
            !unsafepath.contains(state.uri.path)) {
          return '/login';
        }
        return null;
      },
    );
  }
}
