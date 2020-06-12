import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/formModel.dart';

class FormServices {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL.
  static const String URL =
      "masukan API";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  // Default Contructor
  FormServices(this.callback);

  /// Async function which saves form, parses  parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(FormModel formModel) async {
    try {
      await http.get(URL + formModel.toParams()).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
