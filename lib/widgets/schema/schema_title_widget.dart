import 'package:documentation/constants/strings.dart';
import 'package:documentation/constants/text.dart';
import 'package:flutter/material.dart';

const _kBorderRadius = BorderRadius.all(Radius.circular(2));

class SchemaTitleWidget extends StatelessWidget {
  final String title;
  final int itemsCount;
  final Color color;

  const SchemaTitleWidget({
    super.key,
    required this.title,
    required this.itemsCount,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 316.0,
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: _kBorderRadius,
      ),
      child: Material(
        color: color,
        borderRadius: _kBorderRadius,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.0),
            borderRadius: _kBorderRadius,
            color: Colors.transparent,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: kTitleStyle,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '$kOfElements: $itemsCount',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
