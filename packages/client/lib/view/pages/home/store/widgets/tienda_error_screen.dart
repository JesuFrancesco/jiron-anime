import 'package:flutter/material.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class TiendaErrorWidget extends StatelessWidget {
  const TiendaErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Algo salio mal",
                      style: Theme.of(context).textTheme.titleLarge),
                  20.pv,
                  Image.asset(
                    'assets/image/error_placeholder.jpg',
                  ),
                  20.pv,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
