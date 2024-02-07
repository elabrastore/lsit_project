// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:list_fyp_project/screens/constant/image.dart';
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                "Contact Information"
                    .text
                    .fontWeight(FontWeight.bold)
                    .size(20)
                    .make()
                    .pOnly(bottom: 13),
                "Mail: raoanas722@gmail.com".text.size(16).make(),
                "Contact Us: 0306-4279507".text.size(16).make(),
              ],
            ),
            20.heightBox,
            Center(
              child: "Frequently Asked Questions"
                  .text
                  .fontWeight(FontWeight.bold)
                  .size(20)
                  .make()
                  .pOnly(bottom: 16),
            ),
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

            16.heightBox,
            Center(
                child: "How Cash on Delivery works?"
                    .text
                    .bold
                    .size(24)
                    .make()
                    .pOnly(bottom: 13)),
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
