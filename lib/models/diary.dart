class Diary {
  late String mood;
  late String sleep;
  late String food;
  late String water;
  late String exercise;
  late String? note;
  late int moodPoint;
  final dynamic dateTime;

  Diary({
    this.mood = '',
    this.sleep = '',
    this.food = '',
    this.water = '',
    this.exercise = '',
    this.note = '',
    this.moodPoint = 0,
    this.dateTime,
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    print(json['dateTime'].toDate());
    return Diary(
      mood: json['mood'],
      sleep: json['sleep'],
      food: json['food'],
      water: json['water'],
      exercise: json['exercise'],
      note: json['note'],
      moodPoint: json['moodPoint'],
      dateTime: json['dateTime'].toDate(),
    );
  }
}
