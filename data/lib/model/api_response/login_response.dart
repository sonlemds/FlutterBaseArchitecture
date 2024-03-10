import 'package:data/model/base/data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends DataModel {
  @JsonKey(name: "id")
  String? exp;
  @JsonKey(name: "token")
  String? accessToken;

  LoginResponse(this.exp, this.accessToken);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
