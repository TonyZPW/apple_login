import 'package:flutter/material.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app: Sign in with Apple'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SignInWithAppleButton(
              onPressed: () async {
                final credentials = await SignInWithApple.requestCredentials(
                  requests: [
                    AppleIDAuthorizationRequest(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                    ),
                  ],
                );

                print(credentials);

                if (credentials is AuthorizationCredentialAppleID) {
                  /// send credentials to your server to create a session
                  /// after they have been validated with Apple
                } else if (credentials is AuthorizationCredentialPassword) {
                  /// Login the user using username/password combination
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
