
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/domain/usecase/get_package_dropdown.dart';
import 'package:wavenadmin/domain/usecase/update_package.dart';
import 'package:wavenadmin/injection.dart';

part 'get_package_detial_notifier.g.dart';

@riverpod
class GetPackageDetialNotifier extends _$GetPackageDetialNotifier{
  @override
  Future<PackageDetailResponse> build(String idPackage)async{
    final usecase = locator<GetPackageDropdown>();
    return usecase.getPackageDetail(idPackage);
  }

  Future<void> onUpdate(Uint8List gambar,PackageDetailData package)async{
    state = AsyncLoading();
    try {
      final usecase = locator<UpdatePackage>();
      await usecase.execute(idPackage, gambar, package);
      ref.invalidate(getPackageDetialProvider(idPackage));
    } catch (e,s) {
      state = AsyncError(e, s);
    }
  }

}