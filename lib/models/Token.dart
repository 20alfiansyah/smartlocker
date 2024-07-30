// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  final String token;

  const TokenModel({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}
