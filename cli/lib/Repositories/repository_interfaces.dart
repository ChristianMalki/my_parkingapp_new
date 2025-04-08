abstract interface class RepositoryInterface<T> {
  T create(T vehicle);
  List<T> getAll();
  T? getById(int regnr);
  T update(int regnr, T vehicle);
  T delete(int regnr);
}