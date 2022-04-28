import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techy_panther_task/services/user_service.dart';
import 'package:techy_panther_task/utils/field_decoration.dart';
import 'package:techy_panther_task/utils/globals.dart';
import 'package:techy_panther_task/utils/show_snackbar.dart';
import 'package:techy_panther_task/utils/validator.dart';
import 'package:http/http.dart' as http;
class AddNewUserForm extends StatefulWidget {
  const AddNewUserForm({Key? key}) : super(key: key);

  @override
  State<AddNewUserForm> createState() => _AddNewUserFormState();
}

class _AddNewUserFormState extends State<AddNewUserForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String gender = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: GetX<UserServices>(
        builder: (controller) {
          return Container(
            height: 50,
            color: kPrimaryColor,
            child: TextButton(
              child: controller.isLoading.value? CircularProgressIndicator():Text("Add User",style: TextStyle(fontSize: 20,color: Colors.white)),
              onPressed: () async{
                http.Response response = await controller.addNewUser(_nameController.text, _emailController.text, gender);
                showSnackBar("Added Successfully", context);
                _emailController.clear();
                _nameController.clear();
                setState(() {
                  gender="";
                });
                            },
            ),
          );
        }
      ),
      appBar: AppBar(
        title: const Text("Add new user"),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value){
                  if(value == null){
                    return "Cannot be empty";
                  }
                  return null;
                },
                controller: _nameController,
                decoration: fieldDecoration("Enter User Name",Icons.account_circle_outlined)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: validateEmail,
                controller: _emailController,
                decoration: fieldDecoration("Enter email id",Icons.email_outlined)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                  items: ["male", "female"]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        gender = value as String;
                      });
                    }
                  },
                decoration: fieldDecoration("Select gender",Icons.arrow_forward_ios,),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
