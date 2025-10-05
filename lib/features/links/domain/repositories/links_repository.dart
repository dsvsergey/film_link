import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';

/// Links repository interface
abstract class LinksRepository {
  /// Get all links for current user
  Future<Either<Failure, List<LinkEntity>>> getLinks();

  /// Get archived links
  Future<Either<Failure, List<LinkEntity>>> getArchivedLinks();

  /// Get link by id
  Future<Either<Failure, LinkEntity>> getLinkById(int id);

  /// Create new link
  Future<Either<Failure, LinkEntity>> createLink({
    required String url,
    String? title,
    String? description,
    List<String>? tags,
  });

  /// Update link
  Future<Either<Failure, LinkEntity>> updateLink({
    required int id,
    String? url,
    String? title,
    String? description,
    List<String>? tags,
    bool? isArchived,
  });

  /// Delete link
  Future<Either<Failure, void>> deleteLink(int id);

  /// Search links
  Future<Either<Failure, List<LinkEntity>>> searchLinks(String query);

  /// Get directories
  Future<Either<Failure, List<DirectoryEntity>>> getDirectories();

  /// Get directories by user id
  Future<Either<Failure, List<DirectoryEntity>>> getDirectoriesByUserId();

  /// Get directory by id
  Future<Either<Failure, DirectoryEntity>> getDirectoryById(int id);

  /// Create directory
  Future<Either<Failure, DirectoryEntity>> createDirectory({
    required DirectoryEntity directory,
  });

  /// Update directory
  Future<Either<Failure, DirectoryEntity>> updateDirectory({
    required int id,
    required String name,
  });

  /// Delete directory
  Future<Either<Failure, void>> deleteDirectory(int id);

  /// Search directories
  Future<Either<Failure, List<DirectoryEntity>>> searchDirectories(
    String query,
  );
}
