import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/exceptions.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/features/links/data/datasources/links_remote_data_source.dart';
import 'package:film_link/features/links/data/models/directory_model.dart';
import 'package:film_link/features/links/data/models/link_model.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

/// Implementation of LinksRepository
class LinksRepositoryImpl implements LinksRepository {
  final LinksRemoteDataSource remoteDataSource;

  LinksRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LinkEntity>>> getLinks() async {
    try {
      final links = await remoteDataSource.getLinks();
      return Right(links.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LinkEntity>>> getArchivedLinks() async {
    try {
      final links = await remoteDataSource.getArchivedLinks();
      return Right(links.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LinkEntity>> getLinkById(int id) async {
    try {
      final link = await remoteDataSource.getLinkById(id);
      return Right(link.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LinkEntity>> createLink({
    required String url,
    String? title,
    String? description,
    List<String>? tags,
  }) async {
    try {
      final link = await remoteDataSource.createLink(
        url: url,
        title: title,
        description: description,
        tags: tags,
      );
      return Right(link.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LinkEntity>> updateLink({
    required int id,
    String? url,
    String? title,
    String? description,
    List<String>? tags,
    bool? isArchived,
  }) async {
    try {
      final link = await remoteDataSource.updateLink(
        id: id,
        url: url,
        title: title,
        description: description,
        tags: tags,
        isArchived: isArchived,
      );
      return Right(link.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLink(int id) async {
    try {
      await remoteDataSource.deleteLink(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LinkEntity>>> searchLinks(String query) async {
    try {
      final links = await remoteDataSource.searchLinks(query);
      return Right(links.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DirectoryEntity>> createDirectory({
    required DirectoryEntity directory,
  }) async {
    try {
      final newDirectory = await remoteDataSource.createDirectory(
        directory: directory.toModel(),
      );
      return Right(newDirectory.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDirectory(int id) async {
    try {
      await remoteDataSource.deleteDirectory(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DirectoryEntity>>> getDirectories() async {
    try {
      final directories = await remoteDataSource.getDirectories();
      return Right(directories.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DirectoryEntity>>>
  getDirectoriesByUserId() async {
    try {
      final directories = await remoteDataSource.getDirectoriesByUserId();
      return Right(directories.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DirectoryEntity>> getDirectoryById(int id) async {
    try {
      final directory = await remoteDataSource.getDirectoryById(id);
      return Right(directory.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DirectoryEntity>>> searchDirectories(
    String query,
  ) async {
    try {
      final directories = await remoteDataSource.searchDirectories(query);
      return Right(directories.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DirectoryEntity>> updateDirectory({
    required int id,
    required String name,
  }) async {
    try {
      final directory = await remoteDataSource.updateDirectory(
        id: id,
        name: name,
      );
      return Right(directory.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
