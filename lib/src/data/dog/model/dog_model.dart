class DogModel {
  String? pic;

  DogModel({this.pic});

  factory DogModel.fromMap(Map<String, dynamic> map) {
    return DogModel(
      pic: map['message'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'message': pic,
    };
  }
}
