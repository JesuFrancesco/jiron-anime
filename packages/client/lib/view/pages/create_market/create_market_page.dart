import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiron_anime/viewmodel/controllers/market_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/model/service/file_upload_service.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class CreateMarketPage extends StatefulWidget {
  const CreateMarketPage({super.key});

  @override
  State<CreateMarketPage> createState() => _CreateMarketPageState();
}

class _CreateMarketPageState extends State<CreateMarketPage> {
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final marketController = Get.put(MarketController());

  final nameController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final imagePicker = ImagePicker();

  File? _selectedLogo;

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      if (_selectedLogo == null) {
        Get.dialog(
          const InfoDialog(
            title: "¡¡Hey!!",
            message: "Selecciona un logo para tu tienda.",
          ),
        );
        return;
      }

      try {
        isLoading.value = true;
        final service = FileUploadService(context);

        final uploadedFile = await service.uploadSingleFile(_selectedLogo!);

        final logoUrl = uploadedFile!.publicUrl;
        final name = nameController.text;
        final contactEmail = contactEmailController.text;
        final contactPhone = contactPhoneController.text;

        final mercado = Market(
          name: name,
          contactEmail: contactEmail,
          contactPhone: contactPhone,
          logoUrl: logoUrl,
          profileId: AuthService.getProfileId(),
        );

        await marketController.crearNuevoMercado(mercado);

        ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
          const SnackBar(content: Text("¡Tu mercado fue creado exitosamente!")),
        );

        Get.back();
      } catch (e) {
        // DO SOMETHING
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> aniadirLogo() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedLogo = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppbar(title: "Crear Mercado"),
                    30.pv,
                    getDetailsFormWidget(context),
                    30.pv,
                    getImageSelectorWidget(context),
                    30.pv,
                    getCrearTiendaButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCrearTiendaButton() {
    return Obx(
      () =>
          isLoading.value
              ? const SmallCircularIndicator()
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Crear'),
                  ),
                ),
              ),
    );
  }

  Column getDetailsFormWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          "Completa tu información",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        15.pv,
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nombre del mercado'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese al menos un nombre';
            }
            return null;
          },
        ),
        20.pv,
        TextFormField(
          controller: contactEmailController,
          decoration: const InputDecoration(labelText: 'Correo electronico'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese al menos un correo';
            }
            return null;
          },
        ),
        16.pv,
        TextFormField(
          controller: contactPhoneController,
          decoration: const InputDecoration(labelText: 'Telefono'),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese al menos un telefono';
            }
            return null;
          },
        ),
      ],
    );
  }

  Column getImageSelectorWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          "Selecciona tu logo",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        15.pv,
        GestureDetector(
          onTap: aniadirLogo,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black),
            ),
            child:
                _selectedLogo != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(_selectedLogo!, fit: BoxFit.contain),
                    )
                    : const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.black54),
                    ),
          ),
        ),
      ],
    );
  }
}
