import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class KListTile extends StatelessWidget {
  const KListTile({
    super.key,
    this.onTap,
    this.title,
    this.leading,
    this.padding,
    this.trailing,
    this.subtitle,
    this.selected,
    this.onDoubleTap,
    this.onLongPress,
    this.paddingBetweenTitleAndSubtitle,
  });

  final Widget? title;
  final bool? selected;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final double? paddingBetweenTitleAndSubtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: context.theme.primaryColor.withOpacity(0.2),
      splashColor: context.theme.primaryColor.withOpacity(0.5),
      borderRadius: borderRadius12,
      radius: 30,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: _Tile(
        title: title,
        padding: padding,
        leading: leading,
        subtitle: subtitle,
        selected: selected,
        trailing: trailing,
        paddingBetweenTitleAndSubtitle: paddingBetweenTitleAndSubtitle,
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.padding,
    required this.leading,
    required this.selected,
    required this.subtitle,
    required this.trailing,
    required this.paddingBetweenTitleAndSubtitle,
  });

  final Widget? title;
  final bool? selected;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final double? paddingBetweenTitleAndSubtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected == true
            ? context.theme.primaryColor.withOpacity(0.2)
            : null,
        borderRadius: borderRadius15,
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            leading ?? const SizedBox.shrink(),
            const SizedBox(width: 10),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisSize: mainMin,
                crossAxisAlignment: crossStart,
                children: [
                  title ?? const SizedBox.shrink(),
                  if (subtitle != null)
                    SizedBox(height: paddingBetweenTitleAndSubtitle ?? 2.0),
                  subtitle ?? const SizedBox.shrink(),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
