import 'package:shared_preferences/shared_preferences.dart';

import '../model/list_model.dart';

class PreferenceService {
  Future saveSetting(
      {required List<ListModel> tasklist, required ListModel item}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("title", item.title);
    await preferences.setBool("isChecked", item.isChecked);
    await preferences.setString("description", item.description);
  }

  Future<ListModel> getSetting() async {
    final preference = await SharedPreferences.getInstance();
    final title = preference.getInt("title") ?? 0;
    final checked = preference.getBool("isChecked")??false;
    final description = preference.getString("description")??"";

    return ListModel(
        title: title, description: description, isChecked: checked);
  }
}
