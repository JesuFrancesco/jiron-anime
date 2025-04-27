import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/view/pages/home/perfil/widgets/menu_item.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.assistant),
        onPressed: () => Get.toNamed("assistant"),
      ),
      body: CustomLayout(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    16.pv,
                    AuthController.getClipOvalAvatar(),
                    Text(
                      AuthController.fullName ?? 'No hay sesión',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      AuthController.provider ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    16.pv,
                    IconMenuItem(
                      icon: Icons.storefront_outlined,
                      text: 'Mis tiendas',
                      fnOnTap: () {
                        Get.toNamed("/my-markets");
                      },
                    ),
                    IconMenuItem(
                      icon: Icons.shopping_cart_outlined,
                      text: 'Carrito de compras',
                      fnOnTap: () {
                        Get.toNamed("/cart");
                      },
                    ),
                    IconMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      text: 'Mis pedidos',
                      fnOnTap: () {
                        Get.toNamed("/orders");
                      },
                    ),
                    IconMenuItem(
                      icon: Icons.favorite_border_outlined,
                      text: 'Lista de deseados',
                      fnOnTap: () {
                        Get.toNamed("/wishlist");
                      },
                    ),
                    IconMenuItem(
                      icon: Icons.history,
                      text: 'Historial de pedidos',
                      fnOnTap: () {
                        Get.toNamed("/orders-history");
                      },
                    ),
                    IconMenuItem(
                      icon: Icons.chat_outlined,
                      text: 'Foro',
                      fnOnTap: () {
                        Get.toNamed("/forum");
                      },
                    ),
                    IconMenuItem(
                      icon: Icons.settings_outlined,
                      text: 'Ajustes',
                      fnOnTap: () {
                        Get.toNamed("/settings");
                      },
                    ),
                    if (AuthService.isLoggedIn)
                      IconMenuItem(
                        icon: Icons.logout,
                        text: 'Cerrar Sesión',
                        fnOnTap: () async {
                          await AuthService.logout();
                        },
                      ),
                    if (!AuthService.isLoggedIn)
                      IconMenuItem(
                        icon: Icons.login,
                        text: "Iniciar Sesión",
                        fnOnTap: () {
                          Get.toNamed("/sign-in");
                        },
                      ),
                  ],
                ),
              ]),
            ),
            SliverFillRemaining(hasScrollBody: false, child: Container()),
          ],
        ),
      ),
    );
  }
}
