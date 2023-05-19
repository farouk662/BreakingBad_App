class CharacterModel {
  late int charId;
  late String name;
  late String birthday;
  late List<String> occupation;
  late String img;
  late String status;
  late List<int> appearance;
  late String nickname;
  late String portrayed;

  CharacterModel(
      {required this.charId,
        required this.name,
        required this.birthday,
        required this.occupation,
        required this.img,
        required this.status,
        required this.appearance,
        required this.nickname,
        required this.portrayed});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'];
    img = json['img'];
    status = json['status'];
    appearance = json['appearance'].cast<int>();
    nickname = json['nickname'];
    portrayed = json['portrayed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['char_id'] = charId;
    data['name'] = name;
    data['birthday'] = birthday;
    data['occupation'] = occupation;
    data['img'] = img;
    data['status'] = status;
    data['appearance'] = appearance;
    data['nickname'] = nickname;
    data['portrayed'] = portrayed;
    return data;
  }
}