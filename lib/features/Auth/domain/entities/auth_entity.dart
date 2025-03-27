import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthEntity {
  final String id;
  final String email;
  final String displayName;
  final String password;

  const AuthEntity({
    this.id = '', // Provide a default value
    required this.email,
    this.displayName = '', 
    this.password = ''
  });
}
