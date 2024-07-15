import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/pizza/Login/app_text_field.dart';
import 'package:meas/pizza/Login/login_viewmodel.dart';
import 'package:meas/routes/routes.dart';

import 'package:provider/provider.dart';

import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginViewModel loginViewModel = LoginViewModel();

  late StreamSubscription<String> usernameSubscription;
  late StreamSubscription<String> passwordSubscription;
  late LoginViewModel loginViewModel1;

  late SharedPreferences _prefs;

  final GlobalKey<ScaffoldState> _sscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Lắng nghe sự thay đổi từ Stream
    usernameSubscription =
        loginViewModel.usernameStream.listen((String username) {
      print(username);
    });

    passwordSubscription =
        loginViewModel.passwordStream.listen((String password) {
      print(password);
    });

    // Đặt giá trị mặc định cho username và password
    // LoginViewModel.usernameSink.add('admin');
    // LoginViewModel.passwordSink.add('123456789');
    loginViewModel1 = LoginViewModel();
  }

  @override
  void dispose() {
    // Hủy lắng nghe khi widget bị dispose
    usernameSubscription.cancel();
    passwordSubscription.cancel();

    usernameController.dispose();
    passwordController.dispose();

    loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => loginViewModel)],
        child: MaterialApp(
            home: Scaffold(
          body: SafeArea(child: _buildBodyWidget()),
        )));
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFF1F0EF)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 99,
                  ),
                  StreamBuilder<String>(
                    stream: loginViewModel.usernameStream,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 367,
                        child: AppTextField(
                            hintText: "username",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            borderRadius: 10,
                            showOutline: true,
                            onChanged: loginViewModel.usernameSink.add),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<String>(
                    stream: loginViewModel.passwordStream,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 367,
                        child: AppTextField(
                            hintText: "Password ",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            borderRadius: 10,
                            showOutline: true,
                            obscureText: true,
                            onChanged: loginViewModel.passwordSink.add),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: _buildSignButton()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignButton() {
    return StreamBuilder<bool>(
      stream: loginViewModel.loginStream,
      builder: (context, snapshot) {
        return Container(
          child: ElevatedButton(
            child: Text(
              "Sign In",
            ),
            onPressed: snapshot.hasData && snapshot.data == true
                ? () {
                    _login();
                  }
                : null,
          ),
        );
      },
    );
  }

  void _login() {
    loginViewModel.usernameStream.listen((String username) {
      loginViewModel.passwordStream.listen((String password) async {
        if (username.isNotEmpty && password.isNotEmpty) {
          Map<dynamic, dynamic> data = {
            'username': username,
            'password': password,
          };
          final res = await loginViewModel.signin(data);
          String? token = res['token'];

          //  String token = res[1]['token'];

          if (res != null && token != null) {
            Get.snackbar("Nofitication!!!", "Token saved successful",
                colorText: Colors.white,
                icon: const Icon(
                  Icons.check,
                  color: Colors.green, // Thay đổi màu sắc nếu cần
                  size: 24, // Thay đổi kích thước nếu cần
                ));
            Get.offNamed(RouteConfig.mainPage);
          } else {
            print(res);
          }
          // Security security = Security();
          //   await Security.storage.write(key: 'token', value: token);
          // await security.saveToken(token!);
        } else {
          Get.snackbar(
            "Warning!!!",
            "Invalid username or password!",
            colorText: Colors.red,
            icon: const Icon(
              IconData(0x2757, fontFamily: 'Alumi Sans'),
              color: Colors.red,
              size: 30,
            ),
          );
        }
      });
    });
  }
}
