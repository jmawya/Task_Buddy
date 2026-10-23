import 'package:flutter/material.dart';
import 'add_task_screen.dart';

/// Dynamic greeting based on the current time.
String getgreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

/// Dynamic greeting icon.
IconData getIcon() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return Icons.wb_sunny;
  } else if (hour >= 12 && hour < 17) {
    return Icons.wb_sunny_outlined;
  } else if (hour >= 17 && hour < 21) {
    return Icons.wb_twilight;
  } else {
    return Icons.nightlight_round;
  }
}

String? userName;
final List<Map<String, dynamic>> tasks = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {


  final List<Color> cardColors = const [
    Color(0xffFFE0B2), // orange
    Color(0xffC8E6C9), // green
    Color(0xffBBDEFB), // blue
    Color(0xffF8BBD0), // pink
    Color(0xffE1BEE7), // purple
    Color(0xffFFF9C4), // yellow
  ];

  Future<void> openAddTaskPage() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (!mounted) return;
    if (result != null) {
      setState(() {
        tasks.add({
          ...result,
          'color': cardColors[tasks.length % cardColors.length],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
                'TaskBuddy',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
        backgroundColor: Color(0xff7b51ff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting section.
            Row(
              children: [
                Icon(getIcon(), color: Colors.amber, size: 40),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${getgreeting()},',
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      userName?.trim().isNotEmpty == true
                          ? '${userName!.trim()}!'
                          : 'Guest!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'My Tasks',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Task list gets the remaining available height.
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text('No tasks yet. Tap + to add a task.'),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        final date = task['date'] as DateTime;
                        final color = task['color'] as Color;

                        return Card(
                          color: color,
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(task['title'] as String),
                            subtitle: Text(
                              'Due date: ${date.day}/${date.month}/${date.year}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddTaskPage,
        backgroundColor: const Color(0xff4d64ea),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
