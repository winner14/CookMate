import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/constants.dart';
import 'package:mini_project/screens/recipes/recipes.dart';
import 'package:mini_project/widgets/button/button.dart';
import 'package:mini_project/widgets/cards/ingredient_card.dart';
import 'package:mini_project/widgets/drawer/end_drawer.dart';
import 'package:mini_project/widgets/loading_screen/loading_screen.dart';
import 'package:mini_project/widgets/text/cm_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();
  String search = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: myPrimaryColor,
        width: width * .6,
        child: const EndDrawer(),
      ),
      body: FutureBuilder<User?>(
        future: getUserInfo(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: myPrimaryColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/topBg.png'),
                    repeat: ImageRepeat.repeat,
                    opacity: .35),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CMText(
                                  text: 'Hello, ',
                                  color: myBgColorLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                                CMText(
                                  text: userSnapshot
                                      .data!.firstName, // add function later
                                  color: myBgColorLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const CMText(
                              text: 'Ready for a Meal?',
                              color: myBgColorLight,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Builder(
                            builder: (BuildContext context) {
                              return const SizedBox(
                                height: 60,
                                width: 60,
                                child: CircleAvatar(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/boy_profile.png'),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: height * .8,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: myBgColorLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: SizedBox(
                        height: .8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                height: 55,
                                // width: width * .95,
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.search,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: mySecondaryColor,
                                        width: .5,
                                      ),
                                      borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(15),
                                        left: Radius.circular(15),
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(15),
                                        left: Radius.circular(15),
                                      ),
                                      borderSide: BorderSide(
                                          color: mySecondaryColor, width: .5),
                                    ),
                                    iconColor: mySecondaryColor,
                                    // labelText: label,
                                    hintText: 'Search to add ingredients',
                                    // prefixIcon: icon,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        // searchController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.search_rounded,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      search = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GridView.builder(
                                  padding: const EdgeInsets.only(top: 0),
                                  itemCount: 15,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5),
                                  itemBuilder: (context, index) {
                                    return const IngredientCard();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: height * .18,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: myPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 18),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Center(
                                            child: CMText(
                                              text: 'Selected Ingredients',
                                              color: myPrimaryTextColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF045007),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: const Center(
                                              child: CMText(
                                            text: '20',
                                            color: myPrimaryTextColor,
                                            fontSize: 18,
                                          )),
                                        )
                                      ],
                                    ),
                                    CMButton(
                                      text: "Let's Cook!",
                                      textSize: 20,
                                      fontWeight: FontWeight.w500,
                                      width: width * .95,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => const Recipes(),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }

  Future<User?> getUserInfo() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString().trim())
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final documentSnapshot = querySnapshot.docs.first;
      return User.fromJson(documentSnapshot.data());
    } else {
      return null;
    }
  }
}

class User {
  String id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
      );
}
