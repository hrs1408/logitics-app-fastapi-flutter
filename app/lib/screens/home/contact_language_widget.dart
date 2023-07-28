import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
class ContactAndLanguage extends StatelessWidget {
  const ContactAndLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RxString language = 'Vietnamese'.obs;
    return Container(
      color: Colors.white70,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Row(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Color(0XFF00428D),
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                  text: const TextSpan(
                    text: 'Hotline: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '1919',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.email,
                  color: Color(0XFF00428D),
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                  text: const TextSpan(
                    text: 'Email: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'contact@logistics.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Color(0XFF00428D),
                    )),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  color: const Color(0XFF00428D),
                ),
                const SizedBox(
                  width: 10,
                ),
                const FaIcon(
                  FontAwesomeIcons.globe,
                  color: Color(0XFF00428D),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Ngôn ngữ: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.white,
                  child: DropdownButton<String>(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    dropdownColor: Colors.white,
                    value: language.value,
                    items: const <String>['English', 'Vietnamese']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                      );
                    }).toList(),
                    onChanged: (_) {
                      language.value = _ as String;
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
