class DiaryList {
  final String title, content, conditionStatus, weather, date;
  final int diaryNo;

  DiaryList({
    required this.title,
    required this.content,
    required this.conditionStatus,
    required this.weather,
    required this.date,
    required this.diaryNo
  });
}

List<DiaryList> diary_list = [];