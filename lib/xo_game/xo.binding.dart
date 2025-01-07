import 'package:get/get.dart';
import 'package:xo_game/xo_game/xo.vm.dart';

class XoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XOGameVM>(() => XOGameVM());
  }
}
