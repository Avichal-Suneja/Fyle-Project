import 'package:fyle/Modules/Home/home_controller.dart';
import 'package:fyle/Services/api_service.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}