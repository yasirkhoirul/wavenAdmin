import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/pengaturan_model.dart';
import 'package:wavenadmin/data/model/send_whatsapp_request_model.dart';

abstract class PengaturanRemoteDataSource {
  Future<PengaturanModel> getPengaturan();
  Future<PengaturanModel> updatePengaturan(bool isActive);
  Future<SendWhatsappResponse> sendWhatsappMessage(String target, String message);
}

class PengaturanRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements PengaturanRemoteDataSource {
  
  PengaturanRemoteDataSourceImpl(super.dio);

  @override
  Future<PengaturanModel> getPengaturan() async {
    try {
      final response = await dio.dio.get('v1/admin/master/payment-gateway/status');
      return handleResponse(response, (data) => PengaturanModel.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PengaturanModel> updatePengaturan(bool isActive) async {
    try {
      final response = await dio.dio.put('v1/admin/master/payment-gateway/status',
        data: {'is_active': isActive});
      return handleResponse(response, (data) => PengaturanModel.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<SendWhatsappResponse> sendWhatsappMessage(String target, String message) async {
    try {
      final request = SendWhatsappRequest(target: target, message: message);
      final response = await dio.dio.post(
        'v1/admin/whatsapp/send-message',
        data: request.toJson(),
      );
      return SendWhatsappResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
