class ApiRoutes   {
  final String _baseURL = "http://localhost:8000/";
  final String _login = "api/token/";
  final String _verifyToken = "api/token/verify/";

  String get loginRoute => '$_baseURL$_login';
  String get verifyTokenRoute => '$_baseURL$_verifyToken';
}