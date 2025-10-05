import 'package:film_link/features/auth/presentation/providers/auth_providers.dart';
import 'package:film_link/features/links/data/datasources/links_remote_data_source.dart';
import 'package:film_link/features/links/data/repositories/links_repository_impl.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';
import 'package:film_link/features/links/domain/usecases/create_link.dart';
import 'package:film_link/features/links/domain/usecases/delete_link.dart';
import 'package:film_link/features/links/domain/usecases/get_links.dart';
import 'package:film_link/features/links/domain/usecases/update_link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data source provider
final linksRemoteDataSourceProvider = Provider<LinksRemoteDataSource>((ref) {
  return LinksRemoteDataSourceImpl(
    supabaseClient: ref.watch(supabaseClientProvider),
  );
});

// Repository provider
final linksRepositoryProvider = Provider<LinksRepository>((ref) {
  return LinksRepositoryImpl(
    remoteDataSource: ref.watch(linksRemoteDataSourceProvider),
  );
});

// Use case providers
final getLinksUseCaseProvider = Provider<GetLinks>((ref) {
  return GetLinks(ref.watch(linksRepositoryProvider));
});

final createLinkUseCaseProvider = Provider<CreateLink>((ref) {
  return CreateLink(ref.watch(linksRepositoryProvider));
});

final updateLinkUseCaseProvider = Provider<UpdateLink>((ref) {
  return UpdateLink(ref.watch(linksRepositoryProvider));
});

final deleteLinkUseCaseProvider = Provider<DeleteLink>((ref) {
  return DeleteLink(ref.watch(linksRepositoryProvider));
});
