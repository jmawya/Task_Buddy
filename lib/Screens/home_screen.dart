
import 'package:flutter/material.dart';
import 'package:task_buddy/Screens/profile.dart';
import 'calendar_screen.dart';

class TaskItem {
  String title;
  String dueTime;
  bool isCompleted;

  TaskItem({
    required this.title,
    required this.dueTime,
    this.isCompleted = false,
  });
}

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<TaskItem> tasks = [
    TaskItem(
      title: 'Finish Flutter project',
      dueTime: 'Today, 6:00 PM',
      isCompleted: true,
    ),
    TaskItem(
      title: 'Read a book',
      dueTime: 'Today, 8:00 PM',
    ),
    TaskItem(
      title: 'Workout',
      dueTime: 'Tomorrow, 7:00 AM',
      isCompleted: true,
    ),
    TaskItem(
      title: 'Prepare presentation',
      dueTime: 'Tomorrow, 10:00 AM',
    ),
    TaskItem(
      title: 'Meet with friend',
      dueTime: 'Tomorrow, 5:00 PM',
    ),
  ];

  // Automatically calculated task statistics.
  int get totalTasks => tasks.length;

  int get completedTasks =>
      tasks.where((task) => task.isCompleted).length;

  int get pendingTasks => totalTasks - completedTasks;

  // Mark a task as completed or pending.
  void toggleTask(int index, bool value) {
    setState(() {
      tasks[index].isCompleted = value;
    });
  }

  // Add a new task.
  Future<void> addTask() async {
    final controller = TextEditingController();

    final title = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter task name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              Navigator.pop(dialogContext, value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, controller.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (!mounted) return;

    if (title != null && title.trim().isNotEmpty) {
      setState(() {
        tasks.add(
          TaskItem(
            title: title.trim(),
            dueTime: 'No due date',
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TaskBuddy',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff4d64ea),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),

      // Display the selected page.
      body: IndexedStack(
        index: selectedIndex,
        children: [
          buildHomeContent(),
          CalendarScreen(),
          Profile(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
        onPressed: addTask,
        backgroundColor: const Color(0xff4d64ea),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      )
          : null,
    );
  }

  // Home page content.
  Widget buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting section.
          Row(
            children: [
              Icon(
                getIcon(),
                color: Colors.amber,
                size: 40,
              ),
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

          // Total, completed, and pending tasks.
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffededff),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                buildStat('Total', totalTasks),
                buildDivider(),
                buildStat('Completed', completedTasks),
                buildDivider(),
                buildStat('Pending', pendingTasks),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Task list heading.
          const Text(
            'My Tasks',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (tasks.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No tasks yet. Tap + to add a task.'),
              ),
            ),

          // Display each task.
          ...tasks.asMap().entries.map((entry) {
            final index = entry.key;
            final task = entry.value;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    if (value != null) {
                      toggleTask(index, value);
                    }
                  },
                ),
                title: Text(
                  task.title,

                ),
                subtitle: Text(task.dueTime),
                trailing: Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.schedule,
                  color: task.isCompleted
                      ? Colors.green
                      : Colors.blue,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Reusable task statistic widget.
  Widget buildStat(String label, int value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xff173dc1),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff0c44d4),
            ),
          ),
        ],
      ),
    );
  }

  // Divider between statistics.
  Widget buildDivider() {
    return Container(
      width: 1,
      height: 45,
      color: const Color(0xffd4d8f8),
    );
  }
}