abstract class UseCase<Type, Param> {
  Future<Type> call(Param param);
}

abstract class TypeUseCase<Type> {
  Future<Type> call();
}