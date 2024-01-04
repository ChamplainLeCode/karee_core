import 'package:karee/core.dart';
import '/app/services/user_service.dart';

/// Generated by Karee

extension UserServiceExtension on UserService {
  static late final UserService? service;
  static bool loaded = false;
  void init() {
    serverUrl = readConfig('@{server.proxy.url}');
    port = readConfig('@{server.proxy.port}');
    pageSize = readConfig('@{pageable.default.pageSize}');
    username = readConfig('@{security.authorization.username}');
    password = readConfig('@{security.authorization.password}');
    UserServiceExtension.service = this;
    UserServiceExtension.loaded = true;
  }

  UserService get self {
    init();
    return this;
  }
}

UserService $extendedUserService() {
  if (!UserServiceExtension.loaded) {
    UserService().self;
  }
  return UserServiceExtension.service!;
}
