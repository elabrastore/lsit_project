// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 0.2,
                      offset: Offset(4, 4))
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      "Contact Information"
                          .text
                          .fontWeight(FontWeight.bold)
                          .size(20)
                          .make()
                          .pOnly(bottom: 13),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Mail: raoanas722@gmail.com".text.size(16).make(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 128, 1),
                        ),
                        onPressed: () async {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'raoanas722@gmail.com',
                            query: encodeQueryParameters(<String, String>{
                              'subject': 'Welcome to ANAS Store',
                            }),
                          );
                          if (await canLaunchUrl(emailLaunchUri)) {
                            launchUrl(emailLaunchUri);
                          } else {}
                        },
                        child: "Mail".text.white.make(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tel: 0306-4279507".text.size(16).make(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 128, 1),
                          ),
                          onPressed: () async {
                            try {
                              final Uri url = Uri(
                                scheme: "tel",
                                path: "+923064279507",
                              );
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          child: "Contact Us".text.white.make())
                    ],
                  ),
                ],
              ),
            ),
            20.heightBox,
            "Frequently Asked Questions"
                .text
                .fontWeight(FontWeight.bold)
                .size(20)
                .make()
                .pOnly(bottom: 16),
            // Replace the items below with your actual FAQs
            const FAQItem(
                question: "How to contact support?",
                answer:
                    "You can contact support through our email or phone number."),
            const FAQItem(
                question: "What is your return policy?",
                answer:
                    "Our return policy allows returns within 30 days of purchase."),
            const FAQItem(
                question: "How to track my order?",
                answer:
                    "You can track your order in the 'Order History' section of your account."),

            20.heightBox,
            "How Cash on Delivery works?"
                .text
                .bold
                .size(24)
                .make()
                .pOnly(bottom: 13),
            5.heightBox,
            const SizedBox(
              child: Image(
                image: AssetImage(cashonD1),
              ),
            ),
            const SizedBox(
              child: Image(image: AssetImage(cashonD2)),
            )
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: question.text.make(),
      children: [
        answer.text.make().p16(),
      ],
    );
  }
}
