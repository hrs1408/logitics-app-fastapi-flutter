import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    RxDouble width = MediaQuery.of(context).size.width.obs;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0XFF1B2339),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Logistics',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text('Đăng Ký',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Vui lòng đăng ký để sử dụng hệ thống',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          const SizedBox(
                            height: 25,
                          ),
                          buildInput(false, 'Email', Icons.email, width: width),
                          buildInput(true, 'Mật khẩu', Icons.lock,
                              width: width),
                          buildInput(true, 'Nhập lại mật khẩu', Icons.lock,
                              width: width),
                          const SizedBox(
                            height: 25,
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width < 500 ? 20 : 50),
                              child: Column(children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF2B5DFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Đăng Ký',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Bạn đã có tài khoản?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed('/login');
                                      },
                                      child: const Text(
                                        'Đăng nhập',
                                        style: TextStyle(
                                            color: Color(0XFF2B5DFF),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed('/home');
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: width.value > 1200,
                child: Expanded(
                  flex: width < 1200 ? 1 : 7,
                  child: Container(
                    color: const Color(0XFF282E45),
                    child: const Padding(
                      padding: EdgeInsets.all(50),
                      child: Center(
                        child: Image(
                          image: NetworkImage(
                              'https://rsvpify.com/wp-content/uploads/2021/06/Event-Registration-.png'),
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Obx buildInput(bool isPassword, String hintText, IconData iconData,
      {required RxDouble width}) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width < 500 ? 20 : 50, vertical: 15),
          child: TextField(
            obscureText: isPassword,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: iconData != null
                  ? Icon(
                      iconData,
                      color: Colors.white,
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }
}
