enum CharacterType{KID_GIRL, KID_BOY, OLD_LADY,OLD_MAN, YOUNG_LADY, YOUNG_MAN}
class Character{
  CharacterType type;
  String? imgPath;
  String? name;
  String? age;
  List<String>? introStatements;
  Character({required this.type, this.imgPath, this.name, this.age, this.introStatements});
}