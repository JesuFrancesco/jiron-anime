import 'package:flutter/material.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class DescripcionProducto extends StatelessWidget {
  final Product producto;
  const DescripcionProducto({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescripcionInfoWidget(producto: producto),
              const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
              DetallesInfoWidget(producto: producto),
            ],
          ),
        ),
      ],
    );
  }
}

class DescripcionInfoWidget extends StatelessWidget {
  const DescripcionInfoWidget({super.key, required this.producto});

  final Product producto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Descripción",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            10.pv,
          ],
        ),
        Text(
          producto.descripcion != null
              ? producto.descripcion!
              : "No hay descripción",
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class DetallesInfoWidget extends StatelessWidget {
  const DetallesInfoWidget({super.key, required this.producto});

  final Product producto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Detalles del producto",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        10.pv,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...[
                  if (producto.brandSeller != null) const Text("Marca"),
                  if (producto.peso != null) const Text("Peso"),
                  if (producto.formato != null) const Text("Formato"),
                  if (producto.dimensions != null) const Text("Dimensiones"),
                  if (producto.anhoEdicion != null) const Text("Edicion"),
                  if (producto.warranty != null) const Text("Garantia"),
                  if (producto.numeroPaginas != null)
                    const Text("Numero de paginas"),
                  if (producto.productTags != null) const Text("Categoria"),
                ].expand((label) => [label, const SizedBox(height: 8)]),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...[
                  if (producto.brandSeller != null)
                    Text(producto.brandSeller!.name!),
                  if (producto.peso != null) Text(producto.peso!.toString()),
                  if (producto.formato != null) Text(producto.formato!),
                  if (producto.dimensions != null) Text(producto.dimensions!),
                  if (producto.anhoEdicion != null)
                    Text(producto.anhoEdicion!.toString()),
                  if (producto.warranty != null)
                    Text(producto.warranty! == true ? "si" : "no"),
                  if (producto.numeroPaginas != null)
                    Text(producto.numeroPaginas!.toString()),
                  if (producto.productTags != null)
                    Text(
                      producto.productTags!.map((e) => e.tag!.name!).join(", "),
                    ),
                ].expand((label) => [label, const SizedBox(height: 8)]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
