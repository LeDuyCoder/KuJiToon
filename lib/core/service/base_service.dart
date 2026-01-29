abstract class BaseService<T, K> {
  Future<T> call(K params);
}