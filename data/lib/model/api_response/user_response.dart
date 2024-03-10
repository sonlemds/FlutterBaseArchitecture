import 'package:data/model/base/data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends DataModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "email")
  String? email;

  UserResponse(this.id, this.email);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
