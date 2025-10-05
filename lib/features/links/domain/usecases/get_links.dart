import 'package:dartz/dartz.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

/// Use case for getting all links
class GetLinks implements UseCase<List<LinkEntity>, NoParams> {
  final LinksRepository repository;
  
  GetLinks(this.repository);
  
  @override
  Future<Either<Failure, List<LinkEntity>>> call(NoParams params) async {
    return await repository.getLinks();
  }
}
