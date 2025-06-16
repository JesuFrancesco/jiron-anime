import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/view/pages/events/events_page.dart';
import 'package:jiron_anime/viewmodel/controllers/notifications_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/productos_controller.dart';
import 'package:jiron_anime/view/pages/home/notifications/notifications_page.dart';
import 'package:jiron_anime/view/pages/home/search/busqueda_page.dart';
import 'package:jiron_anime/view/pages/home/perfil/perfil_page.dart';
import 'package:jiron_anime/view/pages/home/store/tienda_page.dart';
import 'package:jiron_anime/view/pages/forum/forum_page.dart';
import 'package:jiron_anime/view/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum StoreWidgetType { tienda, buscar, notificaciones, perfil, foro, eventos }

class _HomePageState extends State<HomePage> {
  final productoController = Get.put(ProductoController());
  final notificationController = Get.put(NotificationsController());
  StoreWidgetType _selectedWidget = StoreWidgetType.tienda;
  late Widget _body;

  @override
  void initState() {
    super.initState();
    _body = _getBody(_selectedWidget);
    productoController.obtenerProductosRecientes(1);
    notificationController.obtenerNotificaciones();
  }

  Widget _getBody(StoreWidgetType index) {
    switch (index) {
      case StoreWidgetType.tienda:
        return const TiendaPage();
      case StoreWidgetType.buscar:
        return const BusquedaPage();
      case StoreWidgetType.notificaciones:
        return const NotificationsPage();
      case StoreWidgetType.perfil:
        return const PerfilPage();
      case StoreWidgetType.foro:
        return const ForumPage();
      case StoreWidgetType.eventos:
        return const EventsPage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedWidget = StoreWidgetType.values[index];
      _body = _getBody(_selectedWidget);
    });
  }

  Widget construirPantalla() => _body;

  @override
  Widget build(BuildContext context) {
    // widget
    return Scaffold(
      body: construirPantalla(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColors.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Tienda",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notificaciones",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: "Foros"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Eventos"),
        ],
        currentIndex: _selectedWidget.index,
        onTap: _onItemTapped,
      ),
    );
  }
}
