import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/pregunta_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/productos_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/rating_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/tags_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/wishlist_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/pages/home/store/product/widget/producto_descripcion.dart';
import 'package:jiron_anime/view/pages/home/store/product/widget/producto_comentarios.dart';
import 'package:jiron_anime/view/pages/home/store/product/widget/product_stock.dart';
import 'package:jiron_anime/view/pages/home/store/product/widget/ui/similar_product.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/pages/home/search/widget/botones.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/pages/home/store/product/widget/product_info.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class ProductoPage extends StatefulWidget {
  final Product producto;

  const ProductoPage({super.key, required this.producto});

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

enum BotonesProducto { descripcionOption, stockOption, comentariosOption }

class _ProductoPageState extends State<ProductoPage> {
  final _memoizer = AsyncMemoizer();

  final productoController = Get.put(ProductoController(), permanent: true);
  final wishlistController = Get.put(WishlistController(), permanent: true);
  final tagController = Get.put(TagController(), permanent: true);

  final preguntasController = Get.put(PreguntaController());
  final ratingsController = Get.put(RatingController());

  late Widget _body;
  late final Map<BotonesProducto, Widget Function()> _bodyWidgets;

  @override
  void initState() {
    super.initState();

    _bodyWidgets = {
      BotonesProducto.descripcionOption:
          () => DescripcionProducto(producto: widget.producto),
      BotonesProducto.stockOption:
          () => StockProducto(producto: widget.producto),
      BotonesProducto.comentariosOption:
          () => PreguntasProducto(
            producto: widget.producto,
            preguntasController: preguntasController,
            ratingsController: ratingsController,
          ),
    };

    _body = _bodyWidgets[BotonesProducto.descripcionOption]!();
  }

  void _onBotonTapped(BotonesProducto opcion) {
    setState(() => _body = _bodyWidgets[opcion]!());
  }

  Future<void> obtenerProductosPorGenero() async {
    return _memoizer.runOnce(() async {
      await tagController.obtenerTagsDeProducto(widget.producto.id!);
      await productoController.obtenerProductosSimilares(
        tagController.currentProductTags.map((e) => e.tag!).toList(),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppbar(),
              ProductoInfo(
                producto: widget.producto,
                preguntasController: preguntasController,
                ratingsController: ratingsController,
              ),
              30.pv,
              Botones(
                onDescripcion: () {
                  _onBotonTapped(BotonesProducto.descripcionOption);
                },
                onStock: () {
                  _onBotonTapped(BotonesProducto.stockOption);
                },
                onPreguntas: () {
                  _onBotonTapped(BotonesProducto.comentariosOption);
                },
              ),
              const Divider(thickness: 1),
              _body,
              15.pv,
              const Row(
                children: [
                  Text(
                    "También te puede interesar...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              15.pv,
              FutureBuilder(
                future: obtenerProductosPorGenero(),
                builder:
                    (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(child: SmallCircularIndicator())
                            : ProductosSimilaresWidget(
                              productoController: productoController,
                            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
