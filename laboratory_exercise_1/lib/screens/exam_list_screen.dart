import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../widgets/exam_card.dart';

class ExamListScreen extends StatelessWidget {
  final String index = '221162';

  final List<Exam> exams = [
    Exam(
      subjectName: 'Напредно програмирање',
      dateTime: DateTime(2025, 11, 12, 16, 0),
      rooms: ['Лаб 1', 'Лаб 3', 'Лаб 12', 'Лаб 13','Лаб 200а', 'Лаб 117'],
    ),
    Exam(
      subjectName: 'Мобилни платформи и програмирање',
      dateTime: DateTime(2025, 11, 17, 14, 0),
      rooms: ['Лаб 117'],
    ),
    Exam(
      subjectName: 'Програмирање на видео игри',
      dateTime: DateTime(2025, 11, 18, 13, 0),
      rooms: ['Лаб 13', 'Лаб 138', 'Лаб 215', 'Лаб 200а', 'Лаб 200ц'],
    ),
    Exam(
      subjectName: 'Веројатност и статистика',
      dateTime: DateTime(2025, 11, 19, 17, 0),
      rooms: ['223', '224', '225', 'АМФ МФ'],
    ),
    Exam(
      subjectName: 'Напреден веб дизајн',
      dateTime: DateTime(2025, 11, 20, 14, 0),
      rooms: ['Лаб 1', 'Лаб 3', 'Лаб 12', 'Лаб 13','Лаб 200а', 'Лаб 117'],
    ),
    Exam(
      subjectName: 'Калкулус',
      dateTime: DateTime(2025, 11, 21, 16, 0),
      rooms: ['223', '224', '225', '310', 'АМФ МФ'],
    ),
    Exam(
      subjectName: 'Компјутерски мрежи и безбедност',
      dateTime: DateTime(2025, 11, 22, 8, 0),
      rooms: ['Лаб 1', 'Лаб 3', 'Лаб 12', 'Лаб 13','Лаб 200а', 'Лаб 117'],
    ),
    Exam(
      subjectName: 'Веб програмирање',
      dateTime: DateTime(2025, 11, 21, 17, 0),
      rooms: ['Лаб 1', 'Лаб 3', 'Лаб 12', 'Лаб 13','Лаб 200а', 'Лаб 117'],
    ),
    Exam(
      subjectName: 'Бази на податоци',
      dateTime: DateTime(2025, 11, 19, 8, 0),
      rooms: ['Лаб 1', 'Лаб 3', 'Лаб 12', 'Лаб 13','Лаб 200а', 'Лаб 117'],
    ),
    Exam(
      subjectName: 'Вовед во науката на податоци',
      dateTime: DateTime(2025, 11, 29, 13, 0),
      rooms: ['Лаб 1', 'Лаб 3', 'Лаб 12', 'Лаб 13','Лаб 200а', 'Лаб 117'],
    ),
    Exam(
      subjectName: 'Основи на роботика',
      dateTime: DateTime(2025, 11, 20, 8, 0),
      rooms: ['Б3.2', 'АМФ ФИНКИ Г'],
    ),
    Exam(
      subjectName: 'Математика 3',
      dateTime: DateTime(2025, 11, 7, 8, 0),
      rooms: ['315', 'Б1', 'Б2.2', 'Б3.2', 'АМФ ФИНКИ Г'],
    ),
  ];

  ExamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sortedExams = List<Exam>.from(exams)
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: Text('Распоред за испити - $index'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sortedExams.length,
              itemBuilder: (context, index) {
                final exam = sortedExams[index];
                return ExamCard(exam: exam);
              },
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(
                top: BorderSide(color: Colors.blue.shade200, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, color: Colors.blue.shade900, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Вкупно испити: ${sortedExams.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}