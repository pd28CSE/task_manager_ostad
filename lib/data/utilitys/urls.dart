class Urls {
  Urls._();

  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String deleteTask = '$_baseUrl/deleteTask';
  static const String getTaskListByStatus = '$_baseUrl/listTaskByStatus';
  static const String updateTaskByStatus = '$_baseUrl/updateTaskStatus';
  static const String getTaskListStatus = '$_baseUrl/taskStatusCount';
  static const String emailVerification = '$_baseUrl/RecoverVerifyEmail';
  static const String otpVerification = '$_baseUrl/RecoverVerifyOTP';
  static const String resetPassword = '$_baseUrl/RecoverResetPass';
}
