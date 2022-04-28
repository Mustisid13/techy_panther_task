import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techy_panther_task/models/users.dart';
import 'package:techy_panther_task/utils/globals.dart';

class UserDetailPage extends StatelessWidget {
  User user;
  UserDetailPage({required this.user ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        decoration: const BoxDecoration(gradient: kLinearGradient),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 20,
          shadowColor: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Hero(
                tag: user.id,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      user.gender == "male"?kMalePlaceHolderLink : kFemalePlaceHolderLink,
                      width: 200,
                      height: 200,
                    )),
              ),
              Expanded(
                  child: Center(
                      child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        color: user.status!="inactive"?Colors.greenAccent : Colors.redAccent,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        user.status.capitalize!,
                        style: const TextStyle(fontSize: 15, letterSpacing: 3),
                      ),
                    ],
                  ),
                ],
              ))),
              ListTile(
                tileColor: kListTileColor,
                leading: const Icon(
                  Icons.email_outlined,
                  color: kIconColor,
                  size: 35,
                ),
                title: Text(
                  user.email,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                tileColor: kListTileColor,
                leading: Icon(
                  user.gender == "female"?Icons.female_outlined:Icons.male_outlined,
                  color: kIconColor,
                  size: 35,
                ),
                title: Text(user.gender.capitalize!,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
