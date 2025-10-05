import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class SearchDirectories implements UseCase<List<DirectoryEntity>, String> {
  final LinksRepository repository;

  SearchDirectories(this.repository);

  @override
  Future<Either<Failure, List<DirectoryEntity>>> call(String params) async {
    return await repository.searchDirectories(params);
  }
}
