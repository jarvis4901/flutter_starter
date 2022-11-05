import 'package:privacy_client/data/api/apis.dart';
import 'package:privacy_client/net/dio_manager.dart';
import 'package:privacy_client/data/models/login_resp_model.dart';

class ApiService {
  void login(Function cb) async {
    dio.get(Apis.LOGIN).then((response) {
      cb(LoginRespModel).fromJson(response.data);
    });
  }
}
