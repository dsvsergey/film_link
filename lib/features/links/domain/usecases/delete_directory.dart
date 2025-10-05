import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

class DeleteDirectory implements UseCase<void, DeleteDirectoryParams> {
  final LinksRepository repository;

  DeleteDirectory(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteDirectoryParams params) async {
    return await repository.deleteDirectory(params.id);
  }
}

class DeleteDirectoryParams extends Equatable {
  final int id;

  const DeleteDirectoryParams(this.id);

  @override
  List<Object?> get props => [id];
}
