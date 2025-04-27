import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reset_controller.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  ResetController control = Get.put(ResetController());

  Widget _buildBody(BuildContext context) {
    return const SafeArea(child: Text('Template Page'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: null,
            body: _buildBody(context)));
  }
}
