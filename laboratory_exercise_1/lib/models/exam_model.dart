class Exam {
  String subjectName;
  DateTime dateTime;
  List<String> rooms;

  Exam({
    required this.subjectName,
    required this.dateTime,
    required this.rooms,
  });

  bool get isPastOrNot {
    return dateTime.isBefore(DateTime.now());
  }

  String get formattedDate {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    return '$day.$month.$year';
  }

  String get formattedTime {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get timeRemaining {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if(difference.isNegative){
      return 'The exam is over.';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;

    return '$days days, $hours hours';
  }

  String get allRooms {
    return rooms.join(', ');
  }
}