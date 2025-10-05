import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class UpdateDirectory
    implements UseCase<DirectoryEntity, UpdateDirectoryParams> {
  final LinksRepository repository;

  UpdateDirectory(this.repository);

  @override
  Future<Either<Failure, DirectoryEntity>> call(
    UpdateDirectoryParams params,
  ) async {
    return await repository.updateDirectory(id: params.id, name: params.name);
  }
}

class UpdateDirectoryParams extends Equatable {
  final int id;
  final String name;

  const UpdateDirectoryParams({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
