import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/view/pages/events/create_edit_event_page.dart';
import 'package:jiron_anime/view/pages/events/events_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';
import 'package:jiron_anime/viewmodel/middleware/auth_middleware.dart';
import 'package:jiron_anime/view/pages/assistant/assistant_page.dart';
import 'package:jiron_anime/view/pages/create_market/create_market_page.dart';
import 'package:jiron_anime/view/pages/history_orders/history_orders_page.dart';
import 'package:jiron_anime/view/pages/home/home_page.dart';
import 'package:jiron_anime/view/pages/mis_tiendas/mis_tiendas_page.dart';
import 'package:jiron_anime/view/pages/settings/settings_page.dart';
import 'package:jiron_anime/view/pages/orders/orders_page.dart';
import 'package:jiron_anime/view/pages/signin/signin_page.dart';
import 'package:jiron_anime/view/pages/wishlist/wishlist_page.dart';
import 'package:jiron_anime/view/pages/forum/forum_page.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/model/service/locale_notification_service.dart';
import 'package:jiron_anime/view/theme/theme.dart';
import 'package:jiron_anime/view/pages/shopping_cart/cart_page.dart';

// anonymous supabase client
final supabase = Supabase.instance.client;

// local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Entrypoint
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();

  await LocaleNotificationService().init();

  initializeSupabase();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/home",
      getPages: [
        GetPage(name: "/home", page: () => const HomePage()),
        GetPage(name: "/settings", page: () => const SettingsPage()),
        GetPage(name: "/sign-in", page: () => const SignInPage()),
        GetPage(name: "/forum", page: () => const ForumPage()),
        GetPage(name: "/assistant", page: () => const AssistantPage()),
        // Rutas protegidas
        GetPage(
          name: "/wishlist",
          page: () => const WishlistPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: "/cart",
          page: () => const ShoppingCartPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: "/orders",
          page: () => const OrdersPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: "/orders-history",
          page: () => const HistoryOrdersPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: "/my-markets",
          page: () => const MisTiendasPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: "/create-market",
          page: () => const CreateMarketPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/events',
          page: () => const EventsPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/create-event',
          page: () => CreateEditEventPage(isEdit: false),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/edit-event',
          page: () => CreateEditEventPage(isEdit: true),
          middlewares: [AuthMiddleware()],
        ),
      ],
      theme: appTheme,
      darkTheme: darkAppTheme,
      onReady: AuthService.setupAuthListener,
    );
  }
}
