import 'package:flutter/material.dart';
import './model/formModel.dart';
import './services/formServices.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("Form Data Pegawai"),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Nama',
                        hintText: 'Masukan Nama'),
                    controller: nameController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.home),
                        labelText: 'Alamat',
                        hintText: 'Masukan Alamat'),
                    controller: dobController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'No. Telp',
                        hintText: 'Masukan No Telp'),
                    controller: mobileNoController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Email',
                        hintText: 'Masukan Email'),
                    controller: emailController,
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.

    // If the form is valid, proceed.
    FormModel formModel = FormModel(nameController.text, emailController.text,
        "'" + mobileNoController.text, dobController.text);

    FormServices formController = FormServices((String response) {
      print("Response: $response");
      if (response == FormServices.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        _showSnackbar("Data Submitted");
      } else {
        // Error Occurred while saving data in Google Sheets.
        _showSnackbar("Error Occurred!");
      }
    });

    _showSnackbar("Submitting Form");

    // Submit 'feedbackForm' and save it in Google Sheets.
    formController.submitForm(formModel);
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
