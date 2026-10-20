
import 'package:flutter/material.dart';
import 'package:task_buddy/Screens/profile.dart';
import 'calendar_screen.dart';

class TaskItem {
  String title;
  DateTime dueDate;
  bool isCompleted;

  TaskItem({
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  });
}

// Dynamic greeting based on the current time.
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

// Dynamic greeting icon.
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

// Replace this value with the signed-in user's name later.
String? userName;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<TaskItem> tasks = [];

  // Task statistics.
  int get totalTasks => tasks.length;

  int get completedTasks =>
      tasks.where((task) => task.isCompleted).length;

  int get pendingTasks => totalTasks - completedTasks;

  // Add a task using the separate dialog.
  Future<void> addTask() async {
    final newTask = await showDialog<TaskItem>(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );

    if (!mounted || newTask == null) return;

    setState(() {
      tasks.add(newTask);
    });
  }

  // Mark a task as completed or pending.
  void toggleTask(int index, bool value) {
    setState(() {
      tasks[index].isCompleted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          buildHomeContent(),
          CalendarScreen(),
          Profile(),
        ],
      ),

      ///bottomNavigationBar
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

      ///floatingActionButton
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      )
          : null,
    );
  }

  // Home page content.
  Widget buildHomeContent() {
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
      body: SingleChildScrollView(
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

            // Task statistics.
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
                  child: Text(
                    'No tasks yet. Tap + to add a task.',
                  ),
                ),
              ),

            /// Display each task.
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
                  subtitle: Text(
                    'Due date: ${task.dueDate.day}/'
                        '${task.dueDate.month}/'
                        '${task.dueDate.year}',
                  ),
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
      ),
    );
  }

  /// Reusable task statistic widget.
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

/// Separate Add Task dialog.
/// This class must remain outside _HomeScreenState.
class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Open the calendar and select a due date.
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (!mounted || date == null) return;

    setState(() {
      _selectedDate = date;
    });
  }

  // Return the new task to HomeScreen.
  void _addTask() {
    final title = _controller.text.trim();

    if (title.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a task name.';
      });
      return;
    }

    Navigator.of(context).pop(
      TaskItem(
        title: title,
        dueDate: _selectedDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Task name',
                hintText: 'Enter your task',
                border: const OutlineInputBorder(),
                errorText: _errorMessage,
              ),
              onChanged: (_) {
                if (_errorMessage != null) {
                  setState(() {
                    _errorMessage = null;
                  });
                }
              },
              onSubmitted: (_) => _addTask(),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                'Due date: ${_selectedDate.day}/'
                    '${_selectedDate.month}/'
                    '${_selectedDate.year}',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addTask,
          child: const Text('Add Task'),
        ),
      ],
    );
  }
}
