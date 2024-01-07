import 'quizz_ques_ans.dart';

class QuizzCategory {
  final String? category;
  final int? id_cat;
  final List<QuizzQues>? questions;


  const QuizzCategory({
    this.category,
    this.id_cat,
    this.questions
  });

factory QuizzCategory.fromJson(Map<String, dynamic> json) {
  var id_cat = json['id_cat'] != null ? json['id_cat'] : 0;
  var category = json['category'] != null ? json['category'] : "";
  List questions = json['questions'] != null ? json['questions'] : [];
  List<QuizzQues> questionList = questions.map((e) => QuizzQues.fromJson(e)).toList();

  return QuizzCategory(
    category: category,
    id_cat: id_cat,
    questions: questionList
  );
}
}