import '../../data/poviders/auth_remote_datasource_provider.dart';
import '../../data/repositories/auth_repository_imp.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


  /* Provide repositories */

final authRepoProvider = Provider<AuthRepository>((ref)  {
  return AuthRepositoryImp(ref.watch(authRemoteDataSourceProvider));
});
