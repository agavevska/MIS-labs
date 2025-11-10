import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../screens/exam_details_screen.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {

    final bool isPast = exam.isPastOrNot;
    final Color cardColor = isPast ? Colors.grey.shade200 : Colors.blue.shade50;
    final Color borderColor = isPast ? Colors.grey.shade400 : Colors.blue.shade300;
    final Color textColor = isPast ? Colors.grey.shade700 : Colors.blue.shade900;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 2),
      ),
      color: cardColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExamDetailsScreen(exam: exam),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.subjectName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: isPast ? Colors.grey.shade600 : Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    exam.formattedDate,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 18,
                    color: isPast ? Colors.grey.shade600 : Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    exam.formattedTime,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: isPast ? Colors.grey.shade600 : Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                    Expanded(
                    child: Text(
                      exam.allRooms,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}