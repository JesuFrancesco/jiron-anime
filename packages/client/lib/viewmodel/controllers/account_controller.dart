import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/account.dart';
import 'package:jiron_anime/model/service/account_service.dart';
import 'package:jiron_anime/model/service/auth_service.dart';

class AccountsController extends GetxController {
  final service = AccountService();

  final cuenta = Account().obs;

  Future<void> obtenerMiCuenta() async {
    if (!AuthService.isLoggedIn) {
      Get.toNamed("/sign-in");
      return;
    }
    cuenta.value = await service.fetchMyAccount();
  }
}
