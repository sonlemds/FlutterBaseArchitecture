import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resources/resources.dart';

class SocialNetworkBox extends StatelessWidget {
  const SocialNetworkBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: AppColors.mischka))),
            backgroundColor: MaterialStateProperty.all<Color?>(AppColors.white),
            surfaceTintColor:
                MaterialStateProperty.all<Color?>(AppColors.white)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset(Assets.google.svgIconPath,
                  width: 24, height: 24),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      )),
      const SizedBox(width: 12),
      Expanded(
          child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: AppColors.mischka))),
            backgroundColor: MaterialStateProperty.all<Color?>(AppColors.white),
            surfaceTintColor:
                MaterialStateProperty.all<Color?>(AppColors.white)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset(Assets.facebook.svgIconPath,
                  width: 24, height: 24),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      )),
      const SizedBox(width: 12),
      Expanded(
          child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: AppColors.mischka))),
            backgroundColor: MaterialStateProperty.all<Color?>(AppColors.white),
            surfaceTintColor:
                MaterialStateProperty.all<Color?>(AppColors.white)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset(Assets.apple.svgIconPath,
                  width: 24, height: 24),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ))
    ]);
  }
}
