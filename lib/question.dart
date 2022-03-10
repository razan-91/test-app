class Question {
  late String questionText = 'questionText';
  String questionImage = 'qustionImage';
  late bool questionAnswer = 'questionAnswer' as bool;
  Question({
    required String q,
    required String i,
    required bool a,
  }) {
    questionText = q;
    questionImage = i;
    questionAnswer = a;
  }
}
