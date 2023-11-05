import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;

  const CustomIconButton({super.key, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: onPressed);
  }

  const CustomIconButton.cancel({super.key, this.onPressed})
      : icon = const Icon(
          Icons.cancel_outlined,
          size: 40,
        );

  const CustomIconButton.confirm({super.key, this.onPressed})
      : icon = const Icon(
          Icons.check_circle_outline,
          size: 40,
        );

  CustomIconButton.star({super.key, required bool selected, this.onPressed})
      : icon = Icon(
          selected ? Icons.star : Icons.star_border,
        );

  const CustomIconButton.filter({super.key, this.onPressed})
      : icon = const Icon(Icons.filter_list);
}
