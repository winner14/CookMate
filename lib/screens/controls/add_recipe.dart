import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project/constants.dart';
import 'package:mini_project/widgets/text/cm_text.dart';
import 'package:mini_project/widgets/button/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final recipeNameController = TextEditingController();
  final ingredientController = TextEditingController();
  final directionController = TextEditingController();
  final durationController = TextEditingController();
  final recipeNameFocusNode = FocusNode();
  final ingredientFocusNode = FocusNode();
  final directionFocusNode = FocusNode();
  final durationFocusNode = FocusNode();
  String steps = '', ingredient = '', recipeName = '';
  int duration = 0;
  double directionsBoxHeight = 0;
  final _formKey = GlobalKey<FormState>();

  // File? image;
  // String imageUrl = '';

  List<String> ingredients = [];
  List<String> directions = [];
  Future<List<String>> oldIngredients = FirebaseFirestore.instance
      .collection('ingredients')
      .get()
      .then((value) => value.docs.map((e) => e['name'].toString()).toList());

  @override
  void dispose() {
    recipeNameController.dispose();
    ingredientController.dispose();
    directionController.dispose();
    durationController.dispose();
    recipeNameFocusNode.dispose();
    ingredientFocusNode.dispose();
    directionFocusNode.dispose();
    durationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const CMText(
            text: 'Add Recipe',
            fontSize: 24,
            fontWeight: FontWeight.w500,
          )),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          recipeNameFocusNode.unfocus();
          ingredientFocusNode.unfocus();
          directionFocusNode.unfocus();
          durationFocusNode.unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? myPrimaryColorDark
                : myPrimaryColorLight,
            image: DecorationImage(
              image: Theme.of(context).brightness == Brightness.dark
                  ? const AssetImage('assets/images/topBgDark.png')
                  : const AssetImage('assets/images/topBg.png'),
              repeat: ImageRepeat.repeat,
              opacity:
                  Theme.of(context).brightness == Brightness.dark ? .15 : .35,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    height: height * .85,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? myBgColorDark
                          : myBgColorLight,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      // const Padding(
                                      //   padding:
                                      //       EdgeInsets.symmetric(vertical: 8.0),
                                      //   child: Row(
                                      //     children: [
                                      //       CMText(
                                      //         text: 'Name of dish',
                                      //         fontSize: 20,
                                      //         color: myTextColorLight,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Container(
                                          height: 60,
                                          width: width * .95,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? myFgColorDark
                                                    : myFgColorLight,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                          ),
                                          child: TextFormField(
                                            controller: recipeNameController,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: recipeNameFocusNode,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  color: Color(0xA0000000),
                                                  fontSize: 18),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: mySecondaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                  right: Radius.circular(15),
                                                  left: Radius.circular(15),
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                  right: Radius.circular(15),
                                                  left: Radius.circular(15),
                                                ),
                                                // borderSide: BorderSide(color: borderColor, width: borderWidth),
                                              ),
                                              iconColor: mySecondaryColor,
                                              hintText: 'Name of Dish',
                                              suffixIcon: recipeNameController
                                                      .text.isEmpty
                                                  ? const SizedBox(
                                                      width: 0,
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        recipeName = '';
                                                        recipeNameController
                                                            .clear();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                recipeName =
                                                    value.trim().toUpperCase();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 8.0),
                                      //   child: Row(
                                      //     children: [
                                      //       CMText(
                                      //         text: 'Ingredients',
                                      //         fontSize: 20,
                                      //         color: Theme.of(context).brightness ==
                                      //                 Brightness.dark
                                      //             ? myTextColorDark
                                      //             : myTextColorDark,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Container(
                                                height: 60,
                                                // width: width * .4,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? myFgColorDark
                                                      : myFgColorLight,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      ingredientController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  focusNode:
                                                      ingredientFocusNode,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        color:
                                                            Color(0xA0000000),
                                                        fontSize: 18),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: mySecondaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius
                                                          .horizontal(
                                                        right:
                                                            Radius.circular(15),
                                                        left:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .horizontal(
                                                        right:
                                                            Radius.circular(15),
                                                        left:
                                                            Radius.circular(15),
                                                      ),
                                                      // borderSide: BorderSide(color: borderColor, width: borderWidth),
                                                    ),
                                                    iconColor: mySecondaryColor,
                                                    hintText: 'Ingredients',
                                                    suffixIcon:
                                                        ingredientController
                                                                .text.isEmpty
                                                            ? const SizedBox(
                                                                width: 0,
                                                              )
                                                            : IconButton(
                                                                onPressed: () {
                                                                  ingredient =
                                                                      '';
                                                                  ingredientController
                                                                      .clear();
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black45,
                                                                ),
                                                              ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      ingredient = value
                                                          .trim()
                                                          .toUpperCase();
                                                      ingredient = ingredient
                                                          .toUpperCase();
                                                    });
                                                  },
                                                  onFieldSubmitted: (value) {
                                                    setState(() {
                                                      ingredients.add(value);

                                                      ingredientController
                                                          .clear();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            ingredients.isNotEmpty
                                                ? Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? myFgColorDark
                                                          : myFgColorLight,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                    ),
                                                    // width: width * .53,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            ingredients.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        2),
                                                            child: Chip(
                                                              label: CMText(
                                                                  text: ingredients[
                                                                      index]),
                                                              onDeleted: () {
                                                                setState(() {
                                                                  ingredients
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                              },
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                : const SizedBox(height: 0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          // Row(
                                          //   children: [
                                          //     CMText(
                                          //       text: 'Directions',
                                          //       fontSize: 20,
                                          //       color:
                                          //           Theme.of(context).brightness ==
                                          //                   Brightness.dark
                                          //               ? myTextColorDark
                                          //               : myTextColorDark,
                                          //     ),
                                          //   ],
                                          // ),
                                          Container(
                                            height: 60,
                                            // width: width * .95,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? myFgColorDark
                                                  : myFgColorLight,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            child: TextFormField(
                                              controller: directionController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              focusNode: directionFocusNode,
                                              decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    color: Color(0xA0000000),
                                                    fontSize: 18),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: mySecondaryColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    right: Radius.circular(15),
                                                    left: Radius.circular(15),
                                                  ),
                                                ),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    right: Radius.circular(15),
                                                    left: Radius.circular(15),
                                                  ),
                                                  // borderSide: BorderSide(color: borderColor, width: borderWidth),
                                                ),
                                                iconColor: mySecondaryColor,
                                                hintText:
                                                    'Add directions step by step',
                                                suffixIcon: directionController
                                                        .text.isEmpty
                                                    ? const SizedBox(
                                                        width: 0,
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          steps = '';
                                                          directionController
                                                              .clear();
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  steps = value;
                                                });
                                              },
                                              onFieldSubmitted: (value) {
                                                setState(() {
                                                  directions.add(value);
                                                  directionsBoxHeight += 35;
                                                  directionController.clear();
                                                });
                                              },
                                            ),
                                          ),
                                          // directions.isNotEmpty
                                          //     ?
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Container(
                                              height: 0 + directionsBoxHeight,
                                              width: width * .95,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? myBgColorDark
                                                    : myBgColorLight,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: ListView.builder(
                                                  reverse: false,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0),
                                                  itemCount: directions.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 1.5),
                                                      child: Container(
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? myFgColorDark
                                                              : myFgColorLight,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(8),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            4.0),
                                                                child: CMText(
                                                                  text:
                                                                      "${index + 1}. ${directions[index]}",
                                                                  fontSize: 18,
                                                                  color: Theme.of(context)
                                                                              .brightness ==
                                                                          Brightness
                                                                              .dark
                                                                      ? myTextColorDark
                                                                      : myTextColorLight,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            4),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      directions
                                                                          .removeAt(
                                                                              index);
                                                                      directionsBoxHeight -=
                                                                          35;
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Theme.of(context).brightness ==
                                                                              Brightness.dark
                                                                          ? myTextColorDark
                                                                          : myTextColorLight,
                                                                      size: 18),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          )
                                          // : const SizedBox(height: 10),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          height: 60,
                                          // width: width * .4,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? myFgColorDark
                                                    : myFgColorLight,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                          ),
                                          child: TextFormField(
                                            controller: durationController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            focusNode: durationFocusNode,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  color: Color(0xA0000000),
                                                  fontSize: 18),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: mySecondaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                  right: Radius.circular(15),
                                                  left: Radius.circular(15),
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                  right: Radius.circular(15),
                                                  left: Radius.circular(15),
                                                ),
                                                // borderSide: BorderSide(color: borderColor, width: borderWidth),
                                              ),
                                              iconColor: mySecondaryColor,
                                              hintText: 'Cooking time',
                                              suffixIcon: durationController
                                                      .text.isEmpty
                                                  ? const SizedBox(
                                                      width: 0,
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        duration = 0;
                                                        durationController
                                                            .clear();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                duration = int.parse(value);
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              // setState(() {
                                              //   directions.add(value);
                                              //   directionController.clear();
                                              // });
                                            },
                                          ),
                                        ),
                                      ),
                                      // image != null
                                      //     ? Container(
                                      //         width: width * .93,
                                      //         height: 200,
                                      //         decoration: BoxDecoration(
                                      //           color: Theme.of(context)
                                      //                       .brightness ==
                                      //                   Brightness.dark
                                      //               ? myFgColorDark
                                      //               : myFgColorLight,
                                      //           borderRadius:
                                      //               const BorderRadius.all(
                                      //             Radius.circular(10),
                                      //           ),
                                      //           image: DecorationImage(
                                      //             image: FileImage(image!),
                                      //             fit: BoxFit.cover,
                                      //           ),
                                      //         ),
                                      //         child: SizedBox(
                                      //           height: double.infinity,
                                      //           child: Column(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.start,
                                      //             children: [
                                      //               SizedBox(
                                      //                 width: double.infinity,
                                      //                 child: Row(
                                      //                   mainAxisAlignment:
                                      //                       MainAxisAlignment.end,
                                      //                   children: [
                                      //                     GestureDetector(
                                      //                       onTap: () {
                                      //                         setState(() {
                                      //                           image = null;
                                      //                         });
                                      //                       },
                                      //                       child: Container(
                                      //                         height: 45,
                                      //                         width: 45,
                                      //                         decoration:
                                      //                             BoxDecoration(
                                      //                           color: Theme.of(context)
                                      //                                       .brightness ==
                                      //                                   Brightness
                                      //                                       .dark
                                      //                               ? Colors
                                      //                                   .black45
                                      //                               : Colors
                                      //                                   .white54,
                                      //                           borderRadius:
                                      //                               const BorderRadius
                                      //                                   .all(
                                      //                             Radius.circular(
                                      //                                 10),
                                      //                           ),
                                      //                         ),
                                      //                         child: Icon(
                                      //                           Icons.close,
                                      //                           color: Theme.of(context)
                                      //                                       .brightness ==
                                      //                                   Brightness
                                      //                                       .dark
                                      //                               ? myTextColorDark
                                      //                               : myTextColorLight,
                                      //                           size: 30,
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : const SizedBox(height: 0),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 8.0),
                                      //   child: CMButton(
                                      //     text: 'Add a picture',
                                      //     width: width * .93,
                                      //     color: Theme.of(context).brightness ==
                                      //             Brightness.dark
                                      //         ? myFgColorDark
                                      //         : myFgColorLight,
                                      //     borderColor: mySecondaryColor,
                                      //     hasIcon: true,
                                      //     icon: Icon(Icons.add_a_photo_outlined,
                                      //         color:
                                      //             Theme.of(context).brightness ==
                                      //                     Brightness.dark
                                      //                 ? myTextColorDark
                                      //                 : myTextColorLight),
                                      //     onPressed: () {
                                      //       // selectPhoto(ImageSource.gallery);
                                      //       showModalBottomSheet(
                                      //         isScrollControlled: true,
                                      //         backgroundColor: Colors.transparent,
                                      //         context: context,
                                      //         builder: (context) =>
                                      //             _selectPhoto(),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CMButton(
                                          text: 'Submit',
                                          onPressed: () async {
                                            if (recipeName.isEmpty ||
                                                ingredients.isEmpty ||
                                                directions.isEmpty ||
                                                duration == 0) {
                                              showSnackbarWithoutAction(
                                                  context,
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? myPrimaryColorDark
                                                      : myPrimaryColorLight,
                                                  'Please fill out all fields');
                                            } else if (directions.length < 3) {
                                              showSnackbarWithoutAction(
                                                  context,
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? myPrimaryColorDark
                                                      : myPrimaryColorLight,
                                                  'Please add at least 3 steps');
                                            } else {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );

                                              final recipes = Recipes(
                                                recipeName: recipeName,
                                                ingredients: ingredients,
                                                steps: directions,
                                                duration: duration,
                                                likes: 0,
                                              );

                                              await addRecipe(recipes);

                                              List test = [];

                                              await oldIngredients
                                                  .then((value) {
                                                value.sort();
                                                value.forEach((element) {
                                                  test.add(element);
                                                });
                                              });

                                              for (int i = 0;
                                                  i < ingredients.length;
                                                  i++) {
                                                bool ingredientInDatabase =
                                                    false;
                                                for (int j = 0;
                                                    j < test.length;
                                                    j++) {
                                                  if (test[j].toLowerCase() ==
                                                      ingredients[i]
                                                          .toLowerCase()) {
                                                    ingredientInDatabase = true;
                                                    break;
                                                  }
                                                }
                                                if (!ingredientInDatabase) {
                                                  final ingredient =
                                                      Ingredients(
                                                    name: ingredients[i],
                                                  );
                                                  await addNewIngredient(
                                                      ingredient);
                                                }
                                              }

                                              Navigator.pop(context);

                                              recipeNameController.clear();
                                              ingredientController.clear();
                                              directionController.clear();
                                              durationController.clear();
                                              setState(() {
                                                ingredients.clear();
                                                directions.clear();
                                                recipeName = '';
                                                duration = 0;
                                                directionsBoxHeight = 0;
                                                // image = null;
                                              });

                                              showSnackbarWithoutAction(
                                                  context,
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? myPrimaryColorDark
                                                      : myPrimaryColorLight,
                                                  'Recipe added successfully');
                                            }

                                            // addImageToFirebase(image!);
                                            // if (image != null) {
                                            //   addImageToFirebase(image!);
                                            //   print('imageUrl $imageUrl');
                                            // }

                                            // oldIngredients.then((value) => {
                                            //       value.sort(),
                                            //       value.forEach((element) {
                                            //         print(element);
                                            //       })
                                            //     });
                                          },
                                          width: double.infinity,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //removing image upload for now

  // Widget _selectPhoto() {
  //   return DraggableScrollableSheet(
  //     initialChildSize: .22,
  //     maxChildSize: .3,
  //     minChildSize: .2,
  //     builder: (_, controller) => Container(
  //       height: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).brightness == Brightness.dark
  //             ? myBgColorDark
  //             : myBgColorLight,
  //         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             CMButton(
  //               text: 'Select from gallery',
  //               width: double.infinity,
  //               onPressed: () {
  //                 selectPhoto(ImageSource.gallery);
  //               },
  //             ),
  //             CMButton(
  //               text: 'Take a photo',
  //               width: double.infinity,
  //               onPressed: () {
  //                 selectPhoto(ImageSource.camera);
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Future selectPhoto(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;

  //     final temporalImage = File(image.path);
  //     setState(() {
  //       this.image = temporalImage;
  //     });
  //   } catch (e) {
  //     showSnackbarWithoutAction(
  //         context,
  //         Theme.of(context).brightness == Brightness.dark
  //             ? myPrimaryColorDark
  //             : myPrimaryColorLight,
  //         e.toString());
  //   }
  // }
  //
  // Future<String?> addImageToFirebase(File? image) async {
  //   try {
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     String name = recipeName;
  //     Reference ref = storage.ref().child('$name.jpg');

  //     await ref.putFile(image!);

  //     imageUrl = await ref.getDownloadURL();

  //     // FirebaseFirestore.instance
  //     //     .collection('recipes')
  //     //     .doc()
  //     //     .update({'imageUrl': imageUrl});
  //     return imageUrl;
  //   } catch (e) {
  //     showSnackbarWithoutAction(
  //         context,
  //         Theme.of(context).brightness == Brightness.dark
  //             ? myPrimaryColorDark
  //             : myPrimaryColorLight,
  //         e.toString());
  //   }
  // }

  // Future<String?> addImageToFirebase(File image, String recipeName) async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref().child('$recipeName.jpg');

  //     final uploadTask = ref.putFile(image);
  //     final snapshot = await uploadTask.whenComplete(() => null);
  //     imageUrl = await snapshot.ref.getDownloadURL();
  //     // imageUrl = url;

  //     FirebaseFirestore.instance
  //         .collection('recipes')
  //         .doc()
  //         .update({'imageUrl': imageUrl});
  //     return imageUrl;
  //   } catch (e) {
  //     showSnackbarWithoutAction(
  //         context,
  //         Theme.of(context).brightness == Brightness.dark
  //             ? myPrimaryColorDark
  //             : myPrimaryColorLight,
  //         e.toString());
  //   }
  // }

  // //read image from firebase
  // Future getImageFromFirebase(String url) async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref().child('$recipeName.jpg');
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } catch (e) {
  //     showSnackbarWithoutAction(
  //         context,
  //         Theme.of(context).brightness == Brightness.dark
  //             ? myPrimaryColorDark
  //             : myPrimaryColorLight,
  //         e.toString());
  //   }
  // }

  Future addRecipe(Recipes recipes) async {
    final formIsValid = _formKey.currentState!.validate();
    if (!formIsValid) {
      return showSnackbarWithoutAction(
          context, Colors.red, 'Please fill in all fields correctly.');
    }

    try {
      final docUser = FirebaseFirestore.instance.collection('recipes').doc();
      final json = recipes.toJson();
      await docUser.set(json);
    } catch (e) {
      showSnackbarWithoutAction(
        context,
        Theme.of(context).brightness == Brightness.dark
            ? myPrimaryColorDark
            : myPrimaryColorLight,
        e.toString(),
      );
    }
  }

  Future addNewIngredient(Ingredients ingredients) async {
    try {
      final docIngredient =
          FirebaseFirestore.instance.collection('ingredients').doc();

      final json = ingredients.toJson();
      await docIngredient.set(json);
    } catch (e) {
      showSnackbarWithoutAction(
          context,
          Theme.of(context).brightness == Brightness.dark
              ? myPrimaryColorDark
              : myPrimaryColorLight,
          e);
    }
  }

  String by(User user) {
    String name = '${user.firstName} ${user.lastName}';
    return name;
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

class Recipes {
  String id;
  final String recipeName;
  final List ingredients;
  final List steps;
  final int duration;
  // final String imageUrl;
  bool isApproved;
  String by;
  final int likes;

  Recipes({
    this.id = '',
    required this.recipeName,
    required this.ingredients,
    required this.steps,
    required this.duration,
    this.isApproved = false,
    this.by = 'Community',
    required this.likes,
    // required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipeName': recipeName,
        'ingredients': ingredients,
        'Steps': steps,
        'duration': duration,
        'isApproved': isApproved,
        'by': by,
        'likes': likes,
        // 'imageUrl': imageUrl,
      };

  static Recipes fromJson(Map<String, dynamic> json) => Recipes(
        id: json['id'],
        recipeName: json['recipeName'],
        ingredients: json['ingredients'],
        steps: json['Steps'],
        duration: json['duration'],
        isApproved: json['isApproved'],
        by: json['by'],
        likes: json['likes'],
        // imageUrl: json['imageUrl'],
      );
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

class Ingredients {
  String id;
  final String name;
  final String category;
  final bool isApproved;

  Ingredients({
    this.id = '',
    this.isApproved = false,
    required this.name,
    this.category = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'isApproved': isApproved,
      };

  static Ingredients fromJson(Map<String, dynamic> json) => Ingredients(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        isApproved: json['isApproved'],
      );
}
