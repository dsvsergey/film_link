import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/usecases/create_directory.dart';
import 'package:film_link/features/links/domain/usecases/delete_directory.dart';
import 'package:film_link/features/links/domain/usecases/get_directories.dart';
import 'package:film_link/features/links/domain/usecases/get_directories_by_user_id.dart';
import 'package:film_link/features/links/domain/usecases/search_directories.dart';
import 'package:film_link/features/links/domain/usecases/update_directory.dart';
import 'package:film_link/features/links/presentation/providers/directory_providers.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_state_provider.freezed.dart';

@freezed
class DirectoryState with _$DirectoryState {
  const factory DirectoryState.initial() = _Initial;
  const factory DirectoryState.loading() = _Loading;
  const factory DirectoryState.loaded(List<DirectoryEntity> links) = _Loaded;
  const factory DirectoryState.error(String message) = _Error;
}

class DirectoryStateNotifier extends StateNotifier<DirectoryState> {
  final GetDirectories _getDirectories;
  final GetDirectoriesByUserId _getDirectoriesByUserId;
  final SearchDirectories _searchDirectories;
  final UpdateDirectory _updateDirectory;
  final DeleteDirectory _deleteDirectory;
  final CreateDirectory _createDirectory;

  DirectoryStateNotifier({
    required GetDirectories getDirectories,
    required GetDirectoriesByUserId getDirectoriesByUserId,
    required SearchDirectories searchDirectories,
    required UpdateDirectory updateDirectory,
    required DeleteDirectory deleteDirectory,
    required CreateDirectory createDirectory,
  }) : _getDirectories = getDirectories,
       _getDirectoriesByUserId = getDirectoriesByUserId,
       _searchDirectories = searchDirectories,
       _updateDirectory = updateDirectory,
       _deleteDirectory = deleteDirectory,
       _createDirectory = createDirectory,
       super(const DirectoryState.initial());

  Future<void> loadDirectories() async {
    state = const DirectoryState.loading();

    final result = await _getDirectories(const NoParams());

    result.fold(
      (failure) => state = DirectoryState.error(failure.message),
      (directories) => state = DirectoryState.loaded(directories),
    );
  }

  Future<void> createDirectory(DirectoryEntity directory) async {
    final result = await _createDirectory(directory);

    result.fold(
      (failure) => state = DirectoryState.error(failure.message),
      (_) => loadDirectories(),
    );
  }

  Future<void> updateDirectory(DirectoryEntity directory) async {
    final UpdateDirectoryParams params = UpdateDirectoryParams(
      id: directory.id,
      name: directory.name,
    );
    final result = await _updateDirectory(params);

    result.fold(
      (failure) => state = DirectoryState.error(failure.message),
      (_) => loadDirectories(),
    );
  }

  Future<void> deleteDirectory(int id) async {
    final result = await _deleteDirectory(DeleteDirectoryParams(id));

    result.fold(
      (failure) => state = DirectoryState.error(failure.message),
      (_) => loadDirectories(),
    );
  }

  Future<void> searchDirectories(String query) async {
    state = const DirectoryState.loading();

    final result = await _searchDirectories(query);

    result.fold(
      (failure) => state = DirectoryState.error(failure.message),
      (directories) => state = DirectoryState.loaded(directories),
    );
  }

  Future<void> getDirectoriesByUserId() async {
    state = const DirectoryState.loading();

    final result = await _getDirectoriesByUserId(const NoParams());

    result.fold(
      (failure) => state = DirectoryState.error(failure.message),
      (directories) => state = DirectoryState.loaded(directories),
    );
  }
}

final directoryStateProvider =
    StateNotifierProvider<DirectoryStateNotifier, DirectoryState>((ref) {
      return DirectoryStateNotifier(
        getDirectories: ref.watch(getDirectoriesUseCaseProvider),
        getDirectoriesByUserId: ref.watch(
          getDirectoriesByUserIdUseCaseProvider,
        ),
        searchDirectories: ref.watch(searchDirectoriesUseCaseProvider),
        updateDirectory: ref.watch(updateDirectoryUseCaseProvider),
        deleteDirectory: ref.watch(deleteDirectoryUseCaseProvider),
        createDirectory: ref.watch(createDirectoryUseCaseProvider),
      );
    });
