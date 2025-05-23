class ApiRoutes   {
  final String _baseURL = "https://finalpitappdev.onrender.com/";
  final String _login = "api/token/";
  final String _verifyToken = "api/token/verify/";
  final String _motionData = "api/motion/";

  String get loginRoute => '$_baseURL$_login';
  String get verifyTokenRoute => '$_baseURL$_verifyToken';

  String get getMotionData => '$_baseURL$_motionData${"get/"}';
}