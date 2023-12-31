import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/constants.dart';
import 'package:mini_project/widgets/button/button.dart';
import 'package:mini_project/widgets/text/cm_text.dart';

import '../widgets/loading_screen/loading_screen.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({super.key});

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  final ingredientNameController = TextEditingController();
  final FocusNode ingredientNameFocusNode = FocusNode();
  String ingredientName = '';
  final _formKey = GlobalKey<FormState>();

  final categories = [
    'Category of Ingredient',
    'Fruits and Vegetables',
    'Fish and Meat',
    'Spices',
    'Others',
  ];

  String? value = 'Category of Ingredient';

  @override
  void dispose() {
    ingredientNameController.dispose();
    ingredientNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ingredientNameFocusNode.unfocus();
      },
      excludeFromSemantics: true,
      child: DraggableScrollableSheet(
        initialChildSize: .8,
        maxChildSize: .8,
        minChildSize: .35,
        builder: (_, controller) => Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? myBgColorDark
                : myBgColorLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: 150,
                        height: 5,
                        decoration: const BoxDecoration(
                            color: mySecondaryColor,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20),
                            )),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? myFgColorDark
                                    : myFgColorLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: ingredientNameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                focusNode: ingredientNameFocusNode,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Please enter a name';
                                //   }
                                //   return null;
                                // },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? myTextColorDark
                                          : myTextColorLight,
                                      fontSize: 18),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mySecondaryColor,
                                      width: 2,
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
                                  ),
                                  iconColor: mySecondaryColor,
                                  labelText: 'Name of Ingredient',
                                  suffixIcon: ingredientNameController
                                          .text.isEmpty
                                      ? const SizedBox(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            ingredientName = '';
                                            ingredientNameController.clear();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ingredientName = value.trim();
                                    ingredientName =
                                        ingredientName.toUpperCase();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? myFgColorDark
                                  : myFgColorLight,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: mySecondaryColor,
                                width: .5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  elevation: 10,
                                  focusColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? myPrimaryColorDark
                                      : myPrimaryColorLight,
                                  dropdownColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? myFgColorDark
                                      : myFgColorLight,
                                  iconSize: 35,
                                  value: value,
                                  items: categories.map(buildMenuItem).toList(),
                                  onChanged: ((value) =>
                                      setState(() => this.value = value)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CMButton(
                            text: 'Submit',
                            width: double.infinity,
                            onPressed: () async {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                              final ingredients = Ingredients(
                                name: ingredientName,
                                category: value!,
                              );
                              await addIngredient(ingredients);

                              ingredientNameController.clear();
                              ingredientName = '';

                              showSnackbarWithoutAction(
                                context,
                                Theme.of(context).brightness == Brightness.dark
                                    ? myPrimaryColorDark
                                    : myPrimaryColorLight,
                                'Ingredient added',
                              );

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  Future addIngredient(Ingredients ingredients) async {
    final formIsValid = _formKey.currentState!.validate();
    if (!formIsValid) {
      return showSnackbarWithoutAction(
        context,
        Colors.red,
        'Please fill in all fields',
      );
    }

    final docIngredient =
        FirebaseFirestore.instance.collection('ingredients').doc();
    // user.id = FirebaseAuth.instance.currentUser!.uid;

    final json = ingredients.toJson();
    await docIngredient.set(json);
  }
}

class Ingredients {
  String id;
  final String name;
  final String category;

  Ingredients({
    this.id = '',
    required this.name,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
      };

  static Ingredients fromJson(Map<String, dynamic> json) => Ingredients(
        id: json['id'],
        name: json['name'],
        category: json['category'],
      );
}
