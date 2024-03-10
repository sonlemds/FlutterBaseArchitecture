import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:resources/resources.dart';

enum InputBoxStatus { def, active, filled, error, disable }

class InputBox extends StatefulWidget {
  InputBox(
      {super.key,
      this.title,
      this.status = InputBoxStatus.def,
      this.onChanged,
      this.onEditingComplete,
      this.onTapOutside,
      this.placeholder,
      this.keyboardType,
      this.initialValue,
      this.textCapitalization = TextCapitalization.none,
      this.inputFormatters,
      this.helpMessage,
      this.obscureText,
      this.prefix,
      this.suffix,
      this.textInputAction});

  final String? title;
  InputBoxStatus status;
  final ValueChanged<String>? onChanged;
  final ValueChanged<PointerDownEvent>? onTapOutside;
  final VoidCallback? onEditingComplete;
  final String? placeholder;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  String? initialValue;
  final String? helpMessage;
  final bool? obscureText;
  final IconData? prefix;
  final IconData? suffix;
  final TextInputAction? textInputAction;

  @override
  State<StatefulWidget> createState() => InputBoxState();
}

class InputBoxState extends State<InputBox> {
  final FocusNode _focus = FocusNode();
  late TextEditingController textEditingController;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible =
        widget.obscureText != null ? !widget.obscureText! : true;
    textEditingController = TextEditingController(text: widget.initialValue);
    if (widget.initialValue != null) {
      _displayValue(widget.initialValue ?? "");
    }
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (widget.status != InputBoxStatus.disable &&
        widget.status != InputBoxStatus.error) {
      setState(() {
        if (_focus.hasFocus) {
          widget.status = InputBoxStatus.active;
        } else {
          if (textEditingController.text.isNotEmpty) {
            widget.status = InputBoxStatus.filled;
          } else {
            widget.status = InputBoxStatus.def;
          }
        }
      });
    }
  }

  void _displayValue(String initialValue) {
    setState(() {
      textEditingController.text = initialValue;
      textEditingController.selection =
          TextSelection.collapsed(offset: initialValue.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == InputBoxStatus.filled) {
      _displayValue(widget.initialValue ?? "");
    }
    return Column(children: [
      widget.title != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.title!,
                    style: AppTextStyles.poppinsStyle.body2
                        .copyWith(color: AppColors.blackPearl)),
                const SizedBox(height: 8)
              ],
            )
          : const SizedBox(),
      SizedBox(
        height: 40,
        child: CupertinoTextField(
          focusNode: _focus,
          onChanged: (value) {
            widget.initialValue = textEditingController.text;
            widget.onChanged?.call(value);
          },
          textAlignVertical: TextAlignVertical.center,
          textInputAction: widget.textInputAction,
          controller: textEditingController,
          obscureText: !_passwordVisible,
          readOnly: widget.status == InputBoxStatus.disable,
          onEditingComplete: widget.onEditingComplete ??
              () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
          onTapOutside: widget.onTapOutside ??
              (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
          padding: const EdgeInsets.symmetric(horizontal: 12),
          placeholder: widget.placeholder,
          keyboardType: widget.keyboardType,
          placeholderStyle: AppTextStyles.poppinsStyle.body2
              .copyWith(color: AppColors.silver),
          style: AppTextStyles.poppinsStyle.body2.copyWith(
              color: widget.status == InputBoxStatus.disable
                  ? AppColors.silver
                  : AppColors.codGray),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: widget.status == InputBoxStatus.error
                    ? AppColors.sunsetOrange
                    : widget.status == InputBoxStatus.active
                        ? AppColors.royalBlue
                        : widget.status == InputBoxStatus.filled
                            ? AppColors.codGray
                            : AppColors.silver),
            color: widget.status == InputBoxStatus.disable
                ? AppColors.wildSand
                : widget.status == InputBoxStatus.error
                    ? AppColors.chablis
                    : AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          prefix: widget.prefix != null
              ? Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(widget.prefix,
                        color: widget.status == InputBoxStatus.error
                            ? AppColors.sunsetOrange
                            : widget.status == InputBoxStatus.active
                                ? AppColors.royalBlue
                                : widget.status == InputBoxStatus.filled
                                    ? AppColors.codGray
                                    : AppColors.silver)
                  ],
                )
              : const SizedBox(),
          suffix: widget.obscureText ?? false
              ? passwordFieldSuffix()
              : widget.suffix != null
                  ? Row(
                      children: [
                        Icon(widget.suffix,
                            color: widget.status == InputBoxStatus.error
                                ? AppColors.sunsetOrange
                                : widget.status == InputBoxStatus.active
                                    ? AppColors.royalBlue
                                    : widget.status == InputBoxStatus.filled
                                        ? AppColors.codGray
                                        : AppColors.silver),
                        const SizedBox(width: 12)
                      ],
                    )
                  : const SizedBox(),
        ),
      ),
      widget.helpMessage != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text(widget.helpMessage!,
                    style: AppTextStyles.poppinsStyle.body2.copyWith(
                        color: widget.status == InputBoxStatus.error
                            ? AppColors.sunsetOrange
                            : AppColors.silver))
              ],
            )
          : const SizedBox(),
    ]);
  }

  Widget passwordFieldSuffix() {
    return GestureDetector(
      child: Row(
        children: [
          Icon(_passwordVisible ? Iconsax.eye : Iconsax.eye_slash,
              color: widget.status == InputBoxStatus.error
                  ? AppColors.sunsetOrange
                  : widget.status == InputBoxStatus.active
                      ? AppColors.royalBlue
                      : widget.status == InputBoxStatus.filled
                          ? AppColors.codGray
                          : AppColors.silver),
          const SizedBox(width: 12)
        ],
      ),
      onTap: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
