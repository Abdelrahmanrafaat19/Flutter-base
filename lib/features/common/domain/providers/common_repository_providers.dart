
import 'package:flutter_base/features/common/data/providers/common_data_sources_provider.dart';
import 'package:flutter_base/features/common/domain/repositories/common_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/common_repository_imp.dart';

final commonRepoProvider = Provider<CommonRepository>((ref)  {
  return CommonRepositoryImp(ref.watch(commonDataSourcesProvider));
});