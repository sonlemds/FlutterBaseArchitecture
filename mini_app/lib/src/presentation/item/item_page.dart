import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontalPadding,
                  vertical: Dimens.verticalPadding),
              child: Column(
                children: [
                  Center(
                      child: Text(
                        'Item Page',
                        style: AppTextStyles.poppinsStyle.heading4,
                      ))
                ],
              ))),
    );
  }
}