

class CustomResponse {
  bool status = false;
  String? msg;

  CustomResponse({required this.status, this.msg});

  @override
  String toString() => 'Status: $status, Msg: $msg';
}
