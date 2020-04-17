import 'package:meta/meta.dart';

@immutable
abstract class AuthorizationCredential {}

class AuthorizationCredentialAppleID implements AuthorizationCredential {
  AuthorizationCredentialAppleID({
    @required this.userIdentifier,
    @required this.givenName,
    @required this.familyName,
    @required this.email,
    @required this.identityToken,
    @required this.authorizationCode,
  })  : assert(userIdentifier != null),
        assert(identityToken != null),
        assert(authorizationCode != null);

  final String userIdentifier;

  /// Can be `null`, will only be returned on the first authorization
  final String givenName;

  /// Can be `null`, will only be returned on the first authorization
  final String familyName;

  /// Can be `null`, will only be returned on the first authorization
  final String email;

  /// Can be `null` on the native side, but is expected on the Flutter side,
  /// as the authorization would be useless without the tokens to validate them
  /// on your own server
  final String identityToken;

  /// Can be `null` on the native side, but is expected on the Flutter side,
  /// as the authorization would be useless without the tokens to validate them
  /// on your own server
  final String authorizationCode;

  @override
  String toString() {
    return 'AuthorizationAppleID($userIdentifier, $givenName, $familyName, $email, identityToken set? ${identityToken != null}, authorizationCode set? ${authorizationCode != null})';
  }
}

class AuthorizationCredentialPassword implements AuthorizationCredential {
  AuthorizationCredentialPassword({
    @required this.username,
    @required this.password,
  })  : assert(username != null),
        assert(password != null);

  final String username;

  final String password;

  @override
  String toString() {
    return 'AuthorizationCredential($username, [REDACTED PASSWORD])';
  }
}

// ignore_for_file: avoid_as
AuthorizationCredential parseCredentialsResponse(
  Map<dynamic, dynamic> response,
) {
  switch (response['type'] as String) {
    case 'appleid':
      return AuthorizationCredentialAppleID(
        userIdentifier: response['userIdentifier'] as String,
        givenName: response['givenName'] as String,
        familyName: response['familyName'] as String,
        email: response['email'] as String,
        identityToken: response['identityToken'] as String,
        authorizationCode: response['authorizationCode'] as String,
      );

    case 'password':
      return AuthorizationCredentialPassword(
        username: response['username'] as String,
        password: response['password'] as String,
      );

    default:
      throw Exception('Unsupported result type ${response['type']}');
  }
}
