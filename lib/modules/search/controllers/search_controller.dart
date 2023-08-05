import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../common/ui.dart';
import '../../../models/search.dart';
import '../../../repositories/search_repository.dart';
import '../../../services/ip_service.dart';

class SearchingController extends GetxController {
  SearchRepository? searchRepository;
  final ipService = Get.find<IpService>();
  final searchResults = Search().obs;
  TextEditingController? textEditingController;

  SearchingController() {
    textEditingController = TextEditingController();
    searchRepository = SearchRepository();
  }

  Future getSearchResults(String mask) async {
    try {
      searchResults.value = await searchRepository!.search(mask);
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: "Ýalňyşlyk ýüze çykdy".tr));
    }
  }
}
