import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginRespModel {
  String? userName;

  LoginRespModel({this.userName});

  LoginRespModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    return data;
  }
}
