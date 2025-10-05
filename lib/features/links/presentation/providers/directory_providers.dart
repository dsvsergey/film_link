import 'package:film_link/features/links/domain/usecases/create_directory.dart';
import 'package:film_link/features/links/domain/usecases/delete_directory.dart';
import 'package:film_link/features/links/domain/usecases/get_directories.dart';
import 'package:film_link/features/links/domain/usecases/get_directories_by_user_id.dart';
import 'package:film_link/features/links/domain/usecases/search_directories.dart';
import 'package:film_link/features/links/domain/usecases/update_directory.dart';
import 'package:film_link/features/links/presentation/providers/links_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createDirectoryUseCaseProvider = Provider<CreateDirectory>((ref) {
  return CreateDirectory(ref.watch(linksRepositoryProvider));
});

final updateDirectoryUseCaseProvider = Provider<UpdateDirectory>((ref) {
  return UpdateDirectory(ref.watch(linksRepositoryProvider));
});

final deleteDirectoryUseCaseProvider = Provider<DeleteDirectory>((ref) {
  return DeleteDirectory(ref.watch(linksRepositoryProvider));
});

final getDirectoriesUseCaseProvider = Provider<GetDirectories>((ref) {
  return GetDirectories(ref.watch(linksRepositoryProvider));
});

final getDirectoriesByUserIdUseCaseProvider = Provider<GetDirectoriesByUserId>((
  ref,
) {
  return GetDirectoriesByUserId(ref.watch(linksRepositoryProvider));
});

final searchDirectoriesUseCaseProvider = Provider<SearchDirectories>((ref) {
  return SearchDirectories(ref.watch(linksRepositoryProvider));
});
