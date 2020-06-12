class FormModel {
  String _name;
  String _email;
  String _mobileNo;
  String _dob;

  FormModel(this._name, this._email, this._mobileNo, this._dob);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&email=$_email&mobileNo=$_mobileNo&dob=$_dob";
}
