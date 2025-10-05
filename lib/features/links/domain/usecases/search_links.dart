import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class SearchLinks implements UseCase<List<LinkEntity>, String> {
  final LinksRepository repository;

  SearchLinks(this.repository);

  @override
  Future<Either<Failure, List<LinkEntity>>> call(String params) async {
    return await repository.searchLinks(params);
  }
}
