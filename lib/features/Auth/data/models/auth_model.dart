import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'auth_model.g.dart';

@immutable
@JsonSerializable()
class AuthModel extends AuthEntity {
  const AuthModel(
      {super.id,
      @JsonKey(name: "email") required super.email,
      required super.displayName,
      @JsonKey(name: "password") super.password});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      email: email,
      displayName: displayName,
      password: password,
    );
  }

  factory AuthModel.fromFirebaseAuthUser(
    firebase_auth.User firebaseUser,
  ) {
    return AuthModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ??
          'Unknown', // Fetching displayName or providing a fallback
      password:
          '', // Password shouldn't be stored or retrieved this way. Consider using a different field.
    );
  }
}
