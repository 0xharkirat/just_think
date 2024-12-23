import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';

class AllAppsWidget extends ConsumerWidget {
  const AllAppsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appListState = ref.watch(installedAppsController);
    final appListNotifier = ref.read(installedAppsController.notifier);

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select apps'),
          primary: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Consumer(builder: (context, ref, _) {
                final selectedApps = ref.watch(selectedAppsController);
                return Text(
                  '${selectedApps.maybeWhen(
                    data: (apps) => apps.length,
                    orElse: () => "-",
                  )}/${appListState.maybeWhen(
                    data: (apps) => apps.length,
                    orElse: () => "-",
                  )}',
                );
              }),
            ),
          ],
        ),
        body: appListState.when(
          skipLoadingOnRefresh:
              true, // Retains the previous data while refreshing
          skipLoadingOnReload:
              true, // Keep on showing the previous data while loading & loading indicator on top of it
          data: (apps) {
            if (apps.isEmpty) {
              return const Center(child: Text('No apps found'));
            }
            return RefreshIndicator(
                onRefresh: appListNotifier.refreshApps,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  itemCount: apps.entries.length,
                  itemBuilder: (context, index) {
                    final entry = apps.entries.elementAt(index);
                    final key = entry.key;
                    final app = entry.value;
                    return Consumer(builder: (context, ref, _) {
                      ref.watch(selectedAppsController);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ListTile(
                          leading: app.icon != null
                              ? Image.memory(app.icon!)
                              : const Icon(Icons.android),
                          title: Text(app.name),
                          trailing: Checkbox(
                            onChanged: (value) {
                              ref
                                  .read(selectedAppsController.notifier)
                                  .toggleApp(
                                    app,
                                    key
                                  );
                            },
                            value: ref
                                .read(selectedAppsController.notifier)
                                .isSelected(key),
                          ),
                          onTap: () {
                            ref.read(selectedAppsController.notifier).toggleApp(
                                  app,
                                  key
                                );
                          },
                        ),
                      );
                    });
                  },
                ));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load apps: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: appListNotifier.refreshApps,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
