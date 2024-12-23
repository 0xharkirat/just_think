import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/apps_controller.dart';

class AppListViewWidget extends ConsumerWidget {
  const AppListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appListState = ref.watch(appListController);
    final appListControllerProvider = ref.read(appListController.notifier);

    return appListState.when(
      skipLoadingOnRefresh: true, // Retains the previous data while refreshing
      skipLoadingOnReload: true, // Keep on showing the previous data while loading & loading indicator on top of it
      data: (apps) {
        if (apps.isEmpty) {
          return const Center(child: Text('No apps found'));
        }
        return RefreshIndicator(
          onRefresh: appListControllerProvider.refreshApps,
          child: ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              return ListTile(
                leading: app.icon != null
                    ? Image.memory(app.icon!)
                    : const Icon(Icons.android),
                title: Text(app.name),
                subtitle: Text(app.packageName),
                onTap: () {},
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Failed to load apps: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: appListControllerProvider.refreshApps,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
