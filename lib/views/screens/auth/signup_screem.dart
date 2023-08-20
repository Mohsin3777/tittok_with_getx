import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/views/widgets/text_inputfield.dart';

import '../../../constant.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Tiktok Clone',
            style: TextStyle(
                fontSize: 35, color: buttonColor, fontWeight: FontWeight.w900),
          ),
      
          const Text(
            'Login',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    'https://thehotelexperience.com/wp-content/uploads/2019/08/default-avatar.png'),
                backgroundColor: Colors.black,
              ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () => authController.pickImage(),
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // userName field
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _userNameController,
              labelText: 'Username',
              icon: Icons.lock,
              isObscured: false,
            ),
          ),
      
          const SizedBox(
            height: 15,
          ),
          // email field
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email,
              isObscured: false,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //  password field
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              isObscured: true,
            ),
          ),
      
          const SizedBox(
            height: 30,
          ),
          Container(
            // width: MediaQuery.of(context).size.width -40,
            height: 50,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              onTap: () => authController.registerUser(
                  _userNameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  authController.profilePhoto),
              child: const Center(
                child: Text(
                  'Reginter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                  onTap: () {
                    print('register');
                  },
                  child: const Text(
                    'Login ',
                    style: TextStyle(fontSize: 20, color: borderColor),
                  ))
            ],
          ),
        ]),
      ),
    ));
  }
}
