import 'ibase_repository.dart';

abstract class IAccountServiceRepository<T> extends IBaseRepository<T> {
  IAccountServiceRepository(super.context);

  Future register(T model);
  Future passwordReset(String email);
  Future signOut();
  Future<String?> signInwithEmail(String email, String pass);
}
