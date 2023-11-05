import 'package:flutter/material.dart';
import 'package:meticulo/widget/buttons.dart';

abstract class CustomDialog {
  final BuildContext context;

  CustomDialog(this.context);
}

class RatingDialog extends CustomDialog {
  RatingDialog(super.context);

  Future<void> _showDialog(
      {required String title,
      required int rating,
      required void Function(int) onConfirmation,
      VoidCallback? onCancellation}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i = 0; i < 5; i++)
                CustomIconButton.star(
                  selected: i < rating,
                  onPressed: () => setState(() => rating = i + 1),
                )
            ])),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomIconButton.cancel(
                onPressed: () async {
                  Navigator.of(context).pop();
                  onCancellation == null ? () => null : onCancellation();
                },
              ),
              CustomIconButton.confirm(
                onPressed: () async {
                  Navigator.of(context).pop();
                  onConfirmation(rating);
                },
              )
            ],
          );
        });
      },
    );
  }

  Future<void> showRating(
          {required String title,
          int rating = 0,
          required void Function(int) onConfirmation,
          VoidCallback? onCancellation}) =>
      _showDialog(
          title: title,
          rating: rating,
          onConfirmation: onConfirmation,
          onCancellation: onCancellation);
}

class FilterDialog extends CustomDialog {
  FilterDialog(super.context);

  Future<void> _showDialog(
      {required void Function() onConfirmation, VoidCallback? onCancellation}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: const SingleChildScrollView(child: Placeholder()),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomIconButton.cancel(
                onPressed: () async {
                  Navigator.of(context).pop();
                  onCancellation == null ? () => null : onCancellation();
                },
              ),
              CustomIconButton.confirm(
                onPressed: () async {
                  Navigator.of(context).pop();
                  onConfirmation();
                },
              )
            ],
          );
        });
      },
    );
  }

  Future<void> showFilter(
          {required void Function() onConfirmation,
          VoidCallback? onCancellation}) =>
      _showDialog(
          onConfirmation: onConfirmation, onCancellation: onCancellation);
}
