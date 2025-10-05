import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class GetDirectoryById
    implements UseCase<DirectoryEntity, GetDirectoryByIdParams> {
  final LinksRepository repository;

  GetDirectoryById(this.repository);

  @override
  Future<Either<Failure, DirectoryEntity>> call(
    GetDirectoryByIdParams params,
  ) async {
    return await repository.getDirectoryById(params.id);
  }
}

class GetDirectoryByIdParams extends Equatable {
  final int id;

  const GetDirectoryByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}
