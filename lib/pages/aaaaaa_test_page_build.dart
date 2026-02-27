import 'package:flutter/material.dart';
import 'package:lsp_system/core/utils/color_utils.dart';

Widget testPageBuild(BuildContext context, Widget icon, String pageName, {String? tip}) {
  ThemeData theme = Theme.of(context);
  TextStyle? testStyle1 = theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary);
  TextStyle? testStyle2 = theme.textTheme.bodyMedium?.copyWith(
    color: ColorUtils.withAlpha(theme.colorScheme.onSurface, 0.85),
  );

  return Theme(
    data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary, size: 80)),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 12),
          Text(pageName, style: testStyle1),
          const SizedBox(height: 12),
          Text(tip ?? 'このページは開発中です', style: testStyle2),
        ],
      ),
    ),
  );
}
