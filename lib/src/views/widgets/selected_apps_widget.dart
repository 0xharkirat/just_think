import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';

class SelectedAppsWidget extends ConsumerWidget {
  const SelectedAppsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedApps = ref.watch(selectedAppsController);
    final selectedAppsNotifier = ref.read(selectedAppsController.notifier);

    return selectedApps.when(

      data: (apps) {
        if (apps.isEmpty) {
          return const Center(child: Text('No apps selected'));
        }
        return RefreshIndicator(
          onRefresh: selectedAppsNotifier.refresh,
          child: ListView.separated(
            itemCount: apps.length,
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Theme.of(context).colorScheme.outline,
            ),
            itemBuilder: (context, index) {
              final entry = apps.entries.elementAt(index);
              final key = entry.key;
              final app = entry.value;
              return Dismissible(
                key: Key(key),
                background: Container(
                  color: Theme.of(context).colorScheme.errorContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.delete,
                      ),
                      Icon(
                        Icons.delete,
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  selectedAppsNotifier.deselectApp(key);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${app.name} removed'),
                      duration: const Duration(
                        seconds: 2,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: app.icon != null
                        ? Image.memory(app.icon!)
                        : const Icon(Icons.android),
                    title: Text(app.name),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) =>Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load apps: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: selectedAppsNotifier.refresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
    );
   
  }
}
