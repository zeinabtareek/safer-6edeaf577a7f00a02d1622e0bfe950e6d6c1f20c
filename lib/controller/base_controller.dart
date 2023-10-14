import 'package:get/get.dart';
import '../enum/view_state.dart';

class BaseController extends GetxController{
  final _state = ViewState.idle.obs;



  ViewState get state => _state.value;

  setState(ViewState state) {
    _state.value = state;
  }
}