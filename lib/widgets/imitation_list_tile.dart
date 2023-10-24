import 'package:flutter/material.dart';

class ImitationListTile extends StatelessWidget {
  const ImitationListTile({
    Key? key,
    required this.title,
    this.subTitle,
    required this.leading,
    this.height,
    required this.onTap,
  }) : super(key: key);

  final Text title;
  final Text? subTitle;
  final Widget leading;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final listSubTitle = subTitle ?? const SizedBox.shrink();
    final listHeight = height ?? 70.0;

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: listHeight),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              leading,
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    listSubTitle,
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
