import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final MealService _mealService = MealService();
  Meal? _meal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMealDetails();
  }

  Future<void> _loadMealDetails() async {
    try {
      final meal = await _mealService.getMealDetails(widget.mealId);
      setState(() {
        _meal = meal;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _launchYouTube() async {
    if (_meal?.mealYoutube != null) {
      final uri = Uri.parse(_meal!.mealYoutube!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
          ? const Center(child: Text('Recipe not found'))
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                _meal!.mealThumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _meal!.mealName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (_meal!.mealCategory != null)
                        Chip(
                          label: Text(_meal!.mealCategory!),
                          backgroundColor: Colors.orange.shade100,
                        ),
                      const SizedBox(width: 8),
                      if (_meal!.mealArea != null)
                        Chip(
                          label: Text(_meal!.mealArea!),
                          backgroundColor: Colors.blue.shade100,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_meal!.mealYoutube != null)
                    ElevatedButton.icon(
                      onPressed: _launchYouTube,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Watch on YouTube'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    color: Colors.orange.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _meal!.ingredients?.entries
                            .map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 8,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${entry.value} ${entry.key}',
                                  style: const TextStyle(
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ))
                            .toList() ??
                            [],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _meal!.mealInstructions ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}