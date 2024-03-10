import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resources/resources.dart';

enum PrimaryButtonStyle { filled, outline }

enum PrimaryButtonStatus { def, loading, disabled }

class PrimaryButton extends StatefulWidget {
  PrimaryButton(
      {super.key,
      this.style = PrimaryButtonStyle.filled,
      this.status = PrimaryButtonStatus.def,
      required this.onPressed,
      this.text});

  final PrimaryButtonStyle? style;
  PrimaryButtonStatus? status;
  final Function() onPressed;
  final String? text;

  @override
  State<StatefulWidget> createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed:
            widget.status == PrimaryButtonStatus.def ? widget.onPressed : null,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                        color: widget.style == PrimaryButtonStyle.outline
                            ? widget.status != PrimaryButtonStatus.disabled
                                ? AppColors.blueMarguerite
                                : AppColors.silver
                            : Colors.transparent))),
            backgroundColor: MaterialStateProperty.all<Color?>(
                widget.style == PrimaryButtonStyle.filled
                    ? widget.status != PrimaryButtonStatus.disabled
                        ? AppColors.blueMarguerite
                        : AppColors.mercury
                    : AppColors.white),
            surfaceTintColor:
                MaterialStateProperty.all<Color?>(AppColors.white)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            widget.status != PrimaryButtonStatus.loading
                ? Text(
                    widget.text ?? '',
                    style: AppTextStyles.poppinsStyle.subTitle2.copyWith(
                        color: widget.status != PrimaryButtonStatus.disabled
                            ? (widget.style == PrimaryButtonStyle.filled
                                ? AppColors.white
                                : AppColors.blueMarguerite)
                            : AppColors.silver),
                  )
                : Lottie.asset(widget.style == PrimaryButtonStyle.filled
                    ? Assets.loadingWhite.lottieAssetPath
                    : Assets.loadingPurple.lottieAssetPath),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
