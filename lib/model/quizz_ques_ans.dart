class  QuizzQues {
  final String? ques;
  final String? answer;
  final List<dynamic>? badAns;

  const QuizzQues({
    this.answer,
    this.badAns,
    this.ques
});
  factory QuizzQues.fromJson(Map<String, dynamic> json) {
    List<dynamic> badAns = json['badAns'] != null ? json['badAns'] : [];
    var ques = json['ques'] != null ? json['ques'] : "";
    var answer = json['answer'] != null ? json['answer'] : "";

    return QuizzQues(
      badAns: badAns,
      ques: ques,
      answer: answer
    );
  }
}