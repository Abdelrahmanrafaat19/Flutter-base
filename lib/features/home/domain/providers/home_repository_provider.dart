
import 'package:flutter_base/features/home/data/repositories/home_repository_imp.dart';
import 'package:flutter_base/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/home_remote_datasource_provider.dart';

final homeRepoProvider = Provider<HomeRepository>((ref)  {
  return HomeRepositoryImp(ref.watch(homeRemoteDataSourceProvider));
});
