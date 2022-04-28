import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:techy_panther_task/models/users.dart';

class UserServices extends GetxController{
  var _users = <User>[].obs;
  var isLoading = false.obs;
  List<User> get  users => _users.value;
  var currentPage = 1.obs;
  var allLoaded = false.obs;
  var totalPages=1.obs;
  set users(List<User> value) {
    _users.value = value;
  }

  String token = "bc1e0809f9bb5ce03125ea49290ec9c8acc225870ebd21e484217e79b88800db";

  @override
  onInit(){
    super.onInit();
    fetchUsersData();
  }
// fetches user data from API
  fetchUsersData()async{
    var tempList = <User>[];
    if(totalPages.value >= currentPage.value) {
      try {
        isLoading.value = true;
        http.Response response = await http.get(
          Uri.parse(
              "https://gorest.co.in/public/v1/users?page=${currentPage.value}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        // checking if we successfully retrieved data or not
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          // getting total pages
          totalPages.value = jsonResponse["meta"]["pagination"]["pages"];
          // temporary list of Users
          // later assigned to users
          tempList = List<User>.from(
              jsonResponse["data"].map((user) => User.fromJson(user)).toList());
          if (currentPage.value != 1) {
            users = users + tempList;
          } else {
            users = tempList;
          }
          currentPage.value++;
        } else {
          print(response.body);
        }
      }catch(e){
print(e.toString());
      }finally{
        isLoading.value=false;
      }
    }else {
      allLoaded.value = true;
    }

  }
// adds new user to database
  Future<http.Response> addNewUser(String name, String email, String gender)async{
    isLoading.value = true;
    http.Response response = await http.post(Uri.parse("https://gorest.co.in/public/v1/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "gender" : gender,
        "status":"Active"
      })
    );
    fetchUsersData();
    isLoading.value = false;
    return response;
  }
}