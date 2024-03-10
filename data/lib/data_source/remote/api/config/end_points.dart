enum EndPoint { signIn, refreshToken, userProfile }

extension EndPointExtension on EndPoint {
  String get endPoint => switch (this) {
        EndPoint.signIn => "/auth-gateway/signin",
        EndPoint.refreshToken => "/auth-gateway/refresh_tokens",
        EndPoint.userProfile => "/users/profile",
      };
}
