import 'package:installed_apps/app_info.dart';

class AppListState {
  final List<AppInfo>? apps;
  final bool isLoading;
  final String? errorMessage;

  const AppListState({
    this.apps,
    this.isLoading = false,
    this.errorMessage,
  });

  AppListState copyWith({
    List<AppInfo>? apps,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AppListState(
      apps: apps ?? this.apps,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
