// Showing List of users
// Pagination applied
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techy_panther_task/screens/add_new_user.dart';
import 'package:techy_panther_task/screens/user_detail_screen.dart';
import 'package:techy_panther_task/services/user_service.dart';
import 'package:techy_panther_task/utils/globals.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();
  UserServices userServices = Get.put(UserServices());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      // checking if we reach the end of list or not
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent){
        // if we are at end of list, load next page
        userServices.fetchUsersData();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNewUserForm()));
        },
        child: const Icon(Icons.add,color:kIconColor,size: 35,),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: kLinearGradient),

        child: GetX<UserServices>(
          builder: (controller) {
            return Stack(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        // on tap we navigate to user detail page.
                        // passing User class Object to display all the details
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailPage(user: controller.users[index],)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                tag: controller.users[index].id,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        controller.users[index].gender == "male"?kMalePlaceHolderLink : kFemalePlaceHolderLink,
                                    width: 100,
                                      height: 100,
                                    )),
                              ),
                              const SizedBox(height: 4,),
                               Text(
                                controller.users[index].name,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: controller.users[index].status!="inactive"?Colors.greenAccent : Colors.redAccent,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      controller.users[index].status.capitalize!,
                                      style: const TextStyle(fontSize: 15, letterSpacing: 3),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
                controller.isLoading.value? const Positioned(
                    child: SizedBox(
                      height: 80,
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()),
                )):const SizedBox()
              ],
            );
          }
        ),
      ),
    );
  }
}
