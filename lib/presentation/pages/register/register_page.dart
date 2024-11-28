import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/constants.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/flix_text_field.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  XFile? xfile;

  bool isHide = true;
  bool isHideConfirm = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref
              .read(routerProvider)
              .goNamed('main', extra: xfile != null ? File(xfile!.path) : null);
        }
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(50),
          Center(
            child: Image.asset(
              'assets/flix_logo.png',
              width: 150,
            ),
          ),
          verticalSpace(50),
          GestureDetector(
            onTap: () async {
              xfile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              setState(() {});
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  xfile != null ? FileImage(File(xfile!.path)) : null,
              child: xfile != null
                  ? null
                  : Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.white,
                    ),
            ),
          ),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FlixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Name',
                  controller: nameController,
                ),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: isHide,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHide ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      // Aksi untuk ikon, misalnya toggle visibility
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                  ),
                ),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Retype Password',
                  controller: retypePasswordController,
                  obscureText: isHideConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHideConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      // Aksi untuk ikon, misalnya toggle visibility
                      setState(() {
                        isHideConfirm = !isHideConfirm;
                      });
                    },
                  ),
                ),
                verticalSpace(28),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? Container(
                          width: double.infinity,
                          height: 42.0,
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: [primeOrange, primeRed]),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (passwordController.text ==
                                  retypePasswordController.text) {
                                ref.read(userDataProvider.notifier).register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text);
                              } else {
                                context.showSnackBar(
                                    "Please retype you password with the same value");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ghostWhite),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const CircularProgressIndicator(),
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Alredy have an account? "),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('login');
                      },
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          color: primeOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
