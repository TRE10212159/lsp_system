import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/core/constants/routes.dart';
import 'package:lsp_system/core/providers/auth_provider.dart';

class PageHeader extends ConsumerWidget {
  const PageHeader({super.key});

  void _handleLogout(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pop();
    await ref.read(authStateProvider.notifier).logout();
    if (context.mounted) context.go(Routes.login.value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 4,
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Row(
          children: [
            Text(
              Routes.getRouteName(GoRouterState.of(context).uri.toString()),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(Day().format('YYYY年MM月DD日(WW)'), style: Theme.of(context).textTheme.bodySmall),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: Dictionary.userName.t(),
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width, kToolbarHeight, 0, 0),
                  items: [
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        leading: const Icon(Icons.logout),
                        title: Text(Dictionary.logout.t()),
                        onTap: () async => _handleLogout(context, ref),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
