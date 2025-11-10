import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../widgets/exam_details.dart';

class ExamDetailsScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailsScreen({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали за испит'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  exam.subjectName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExamDetail(
                        icon: Icons.calendar_today,
                        label: 'Датум',
                        value: exam.formattedDate,
                        color: Colors.blue,
                      ),
                      const Divider(height: 30),

                      ExamDetail(
                        icon: Icons.access_time,
                        label: 'Време',
                        value: exam.formattedTime,
                        color: Colors.orange,
                      ),
                      const Divider(height: 30),

                      ExamDetail(
                        icon: Icons.location_on,
                        label: 'Простории',
                        value: exam.allRooms,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Card(
                elevation: 4,
                color: exam.isPastOrNot ? Colors.grey.shade100 : Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          exam.isPastOrNot ? Icons.check_circle : Icons.timer,
                          size: 50,
                          color: exam.isPastOrNot ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          exam.isPastOrNot ? 'Статус' : 'Преостанато време',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: exam.isPastOrNot ? Colors.grey.shade700 : Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          exam.timeRemaining,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: exam.isPastOrNot ? Colors.grey.shade600 : Colors.green.shade900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'Назад кон листа',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}