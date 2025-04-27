import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:jiron_anime/viewmodel/controllers/market_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/file_upload_service.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/double_parse.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class AgregarProductoScreen extends StatefulWidget {
  final Market market;
  const AgregarProductoScreen({super.key, required this.market});

  @override
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  final isLoading = false.obs;

  List<File> _selectedImages = [];
  bool garantia = false;

  List<TextEditingController> categoryControllers = [];
  List<String> categories = [];

  final ImagePicker _picker = ImagePicker();

  final marketController = Get.put(MarketController());

  final nombreController = TextEditingController();
  final precioController = TextEditingController();
  final stockController = TextEditingController();

  final descripcionController = TextEditingController();
  final formatoController = TextEditingController();
  final dimensionesController = TextEditingController();
  final marcaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> uploadImage() async {
    final pickedFiles = await _picker.pickMultiImage();

    setState(() {
      _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppbar(title: "Agregar producto"),
                    20.pv,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          getAgregarInfoWidget(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          getAgregarDescripcionFormatoWidget(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          getAgregarImagenesWidget(context),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          getAgregarDetallesWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
                20.pv,
                getCreateProductButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCreateProductButton() {
    return isLoading.value
        ? const SmallCircularIndicator()
        : Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: handleEnviar,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text('Agregar', style: TextStyle(fontSize: 16)),
            ),
          ),
        );
  }

  Column getAgregarInfoWidget() {
    return Column(
      children: [
        const Text(
          'Información general',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        10.pv,
        TextFormField(
          controller: nombreController,
          decoration: const InputDecoration(
            labelText: 'Nombre',
            prefixIcon: Icon(Icons.text_fields),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El nombre es obligatorio';
            }
            return null;
          },
        ),
        10.pv,
        TextFormField(
          controller: precioController,
          decoration: const InputDecoration(
            labelText: 'Precio',
            prefixIcon: Icon(Icons.attach_money),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El precio es obligatorio';
            }
            return null;
          },
        ),
        10.pv,
        TextFormField(
          controller: stockController,
          decoration: const InputDecoration(
            labelText: 'Stock',
            prefixIcon: Icon(Icons.inventory),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El stock es obligatorio';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget getAgregarDescripcionFormatoWidget() {
    return Column(
      children: [
        const Text(
          'Descripción y Formato',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        10.pv,
        TextField(
          controller: descripcionController,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Descripción',
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
        10.pv,
        TextField(
          controller: formatoController,
          decoration: const InputDecoration(
            labelText: 'Formato',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Column getAgregarDetallesWidget() {
    return Column(
      children: [
        const Text(
          'Detalles',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        10.pv,
        Row(
          children: [
            const Text('Garantía', style: TextStyle(fontSize: 16)),
            const Spacer(),
            Switch(
              value: garantia,
              onChanged: (value) {
                setState(() {
                  garantia = value;
                });
              },
            ),
          ],
        ),
        10.pv,
        TextField(
          controller: dimensionesController,
          decoration: const InputDecoration(
            labelText: 'Dimensiones',
            prefixIcon: Icon(Icons.straighten),
            border: OutlineInputBorder(),
          ),
        ),
        10.pv,
        TextField(
          controller: marcaController,
          decoration: const InputDecoration(
            labelText: 'Marca',
            prefixIcon: Icon(Icons.branding_watermark),
            border: OutlineInputBorder(),
          ),
        ),
        10.pv,
        const Divider(),
        10.pv,
        Text("Categorias", style: Theme.of(context).textTheme.titleMedium),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: categoryControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Categoría ${index + 1}',
                        prefixIcon: const Icon(Icons.category),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        categories.removeAt(index);
                        categoryControllers[index].dispose();
                        categoryControllers.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              categories.add('');
              categoryControllers.add(TextEditingController());
            });
          },
          child: const Text('Agregar Categoría'),
        ),
      ],
    );
  }

  Widget getAgregarImagenesWidget(BuildContext context) {
    return Column(
      children: [
        Text("Agrega imágenes", style: Theme.of(context).textTheme.titleMedium),
        10.pv,
        GestureDetector(
          onTap: uploadImage,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black),
            ),
            child:
                _selectedImages.isNotEmpty
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        _selectedImages.first,
                        fit: BoxFit.contain,
                      ),
                    )
                    : const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.black54),
                    ),
          ),
        ),
        10.pv,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _selectedImages.skip(1).map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  void handleEnviar() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;

        final service = FileUploadService(context);

        final uploadedFiles = await service.uploadMultipleFiles(
          _selectedImages,
        );

        // Crear algunas instancias de modelos para subida de producto final
        final tags =
            categoryControllers
                .map((e) => ProductTag(tag: Tag(name: e.text)))
                .toList();

        final marca = BrandSeller(name: marcaController.text);

        final productAttachments =
            uploadedFiles
                .map((e) => ProductAttachment(imageUrl: e.publicUrl))
                .toList();

        final producto = Product(
          name: nombreController.text,
          price: parseToDouble(precioController.text),
          stock: int.parse(stockController.text),
          descripcion: descripcionController.text,
          formato: formatoController.text,
          productTags: tags,
          dimensions: dimensionesController.text,
          brandSeller: marca,
          productAttachments: productAttachments,
        );

        await marketController.agregarNuevoProducto(
          producto,
          widget.market.id!,
        );

        ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
          const SnackBar(
            content: Text("¡Tu producto fue creado exitosamente!"),
          ),
        );

        Get.until((route) => Get.currentRoute == '/home');
      } catch (e) {
        // DO SOMETHING
      } finally {
        isLoading.value = false;
      }
    }
  }
}
