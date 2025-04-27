import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/location_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/order_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/shopping_cart_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/pages/payment/widget/pasarela_pago.dart';
import 'package:jiron_anime/view/pages/payment/widget/product_resume.dart';
import 'package:jiron_anime/view/pages/payment/widget/separador.dart';
import 'package:jiron_anime/view/pages/payment_success/payment_success_page.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:latlong2/latlong.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final shoppingCartController = Get.put(ShoppingCartController());
  final orderController = Get.put(OrderController());
  final locationController = Get.put(LocationController());
  final mapController = MapController();

  final paymentLoading = false.obs;
  final fechaEntrega = DateTime.now().add(const Duration(days: 7)).obs;
  final ubicacionEntrega = const LatLng(0, 0).obs;

  get cartItems => shoppingCartController.cartItems;

  @override
  void initState() {
    super.initState();
    locationController.checkPermisoDeUbicacion();
  }

  Future<void> handleRealizarPedidoOnClick() async {
    try {
      final itemsOrden = List<OrderItem>.from(
        cartItems.map(
          (e) => OrderItem(
            amount: e.amount,
            product: e.product,
            productId: e.productId,
          ),
        ),
      );

      final order = await orderController.procesarOrdenDeCompra(itemsOrden);

      Get.offAll(() => PaymentSuccessPage(order: order));
    } catch (e) {
      // HANDLE ERRORS
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppbar(title: "Pago"),
                  SizedBox(
                    height: 144,
                    child: ListView.builder(
                      itemCount: cartItems!.length,
                      itemBuilder: (context, index) {
                        final item = cartItems![index];
                        return ProductResumeWidget(item: item, onRemove: () {});
                      },
                    ),
                  ),
                  const Separador(),
                  ...getUbicacionPicker,
                  const Separador(),
                  ...getFechaDeEnvioPicker(context),
                  const Separador(),
                  ...getPasarelaDePagoPicker,
                  const Separador(),
                  ...getDatosAdicionalesPicker,
                  const Separador(),
                  ...getDiscountCodePicker,
                  const Separador(),
                  Text(
                    'Total: S/. ${cartItems!.fold(0, (sum, cartItem) => sum + (cartItem.product!.price! * cartItem.amount!).toInt())}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.pv,
                  getRealizarPedidoButton(),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'Al realizar un pedido, aceptas nuestros términos y condiciones.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get getUbicacionPicker {
    return [
      const Text(
        'ENTREGA - GRATIS',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Obx(
        () => Text(
          'Ubicación: ${locationController.latitud.toStringAsFixed(5)} ${locationController.longitud.toStringAsFixed(5)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      FutureBuilder<void>(
        future: locationController.actualizarMapController(mapController),
        builder:
            (ctx, snapshot) =>
                (locationController.isLoading.value)
                    ? const Center(child: SmallCircularIndicator())
                    : Container(
                      height: 256,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Obx(
                        () => FlutterMap(
                          key: locationController.mapKey,
                          // MODO GPS
                          mapController: mapController,
                          options: MapOptions(
                            initialZoom: 15,
                            minZoom: 15,
                            // maxZoom: 25,
                            initialCenter: LatLng(
                              locationController.latitud.value,
                              locationController.longitud.value,
                            ),
                            onTap: (tapPosition, point) {
                              locationController.latitud.value = point.latitude;
                              locationController.longitud.value =
                                  point.longitude;
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.jiron_anime',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    locationController.latitud.value,
                                    locationController.longitud.value,
                                  ),
                                  child: const Icon(
                                    Icons.location_on,
                                    size: 40.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
      ),
    ];
  }

  List<Widget> getFechaDeEnvioPicker(BuildContext context) {
    return [
      GestureDetector(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now().add(const Duration(days: 3)),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
          );

          if (date == null) return;

          fechaEntrega.value = date;
        },
        child: Obx(
          () => ListTile(
            title: const Text('Fecha de envío'),
            subtitle: Text(
              "Tu pedido llegará el ${fechaEntrega.value.day}/${fechaEntrega.value.month}/${fechaEntrega.value.year}",
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> get getDiscountCodePicker {
    return [
      GestureDetector(
        onTap: () {
          Get.snackbar("WIP", "Esta funcionalidad aún está en desarrollo.");
        },
        child: const ListTile(
          title: Text('Código de descuento'),
          subtitle: Text('ULIMA2024', style: TextStyle(color: Colors.blue)),
        ),
      ),
    ];
  }

  List<Widget> get getDatosAdicionalesPicker {
    return [
      GestureDetector(
        onTap: () {
          Get.snackbar("WIP", "Esta funcionalidad aún está en desarrollo.");
        },
        child: ListTile(
          title: const Text('Tus datos'),
          subtitle: Text(
            "Usuario: ${AuthController.fullName!}",
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    ];
  }

  List<Widget> get getPasarelaDePagoPicker {
    return [
      GestureDetector(
        onTap: () {
          Get.to(() => const MockPasarelaDePago());
        },
        child: const ListTile(
          title: Text('Pago'),
          subtitle: Text(
            'Tu MasterCard que termina en 7777',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    ];
  }

  Widget getRealizarPedidoButton() {
    return Obx(
      () =>
          orderController.isLoading.value
              ? const SmallCircularIndicator()
              : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: handleRealizarPedidoOnClick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'REALIZAR PEDIDO',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
    );
  }
}
