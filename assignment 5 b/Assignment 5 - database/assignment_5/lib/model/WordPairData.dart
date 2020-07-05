
import 'package:english_words/english_words.dart';

const String tableName = 'WordPair';
const String idColumn = 'id';
const String firstNameColumn = "firstName";
const String secondNameColumn = "secondName";
const String isSaved = 'isSaved';

class WordPairData {
  int id;
  WordPair pair;
  bool saved;

  WordPairData(this.pair, this.saved);

  Map<String, dynamic> toMap() => {
    firstNameColumn: pair.first ,
    secondNameColumn: pair.second,
    isSaved: saved == true ? 1 : 0
  };

  WordPairData.fromMap(Map<String, dynamic> map) {
    id = map[idColumn];
    pair = WordPair(map[firstNameColumn], map[secondNameColumn]);
    saved = map[isSaved] == 1;
  }
}