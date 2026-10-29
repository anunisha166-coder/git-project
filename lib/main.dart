
import 'package:flutter/material.dart';

void main() {
  runApp(const AnunishaApp());
}

const Color purple = Color(0xFF6C4AB6);
const Color pink = Color(0xFFE8A0BF);
const Color bgColor = Color(0xFFF7F4FC);

class AnunishaApp extends StatelessWidget {
  const AnunishaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anunisha Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        scaffoldBackgroundColor: bgColor,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// LOGIN PAGE
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController(text: 'Anunisha');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty ||
        !email.contains('@') ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid login details'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainPage(name: name, email: email),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [purple, pink],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.checklist_rounded,
                  color: Colors.white,
                  size: 65,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: purple,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Login to your personal task manager'),
              const SizedBox(height: 35),
              TextField(
                controller: nameController,
                decoration: inputStyle('Full Name', Icons.person_outline),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputStyle('Email Address', Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: inputStyle('Password', Icons.lock_outline),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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

InputDecoration inputStyle(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: purple),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
  );
}

// MAIN PAGE
class MainPage extends StatefulWidget {
  final String name;
  final String email;

  const MainPage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> tasks = [
    {'title': 'Learn Flutter', 'done': false},
    {'title': 'Finish Assignment', 'done': false},
    {'title': 'Practice Dart', 'done': true},
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      taskPage(),
      profilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ['Dashboard', 'My Tasks', 'My Profile'][currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: purple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        backgroundColor: Colors.white,
        indicatorColor: pink.withValues(alpha: 0.4),
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // HOME PAGE
  Widget homePage() {
    final completed = tasks.where((t) => t['done'] == true).length;
    final pending = tasks.length - completed;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [purple, Color(0xFF9B72CF)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR PRODUCTIVITY',
                style: TextStyle(color: Colors.white70, letterSpacing: 1.5),
              ),
              const SizedBox(height: 12),
              Text(
                'Hello, ${widget.name}!',
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Make today count. One task at a time!',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'Task Overview',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            statCard('Total', '${tasks.length}', Icons.list_alt, purple),
            statCard('Pending', '$pending', Icons.schedule, Colors.orange),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            statCard(
              'Completed',
              '$completed',
              Icons.task_alt,
              Colors.green,
            ),
            statCard(
              'Progress',
              tasks.isEmpty
                  ? '0%'
                  : '${(completed * 100 / tasks.length).round()}%',
              Icons.trending_up,
              Colors.pink,
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Recent Tasks',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...tasks.take(3).map(
          (task) => Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(
                task['done']
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: purple,
              ),
              title: Text(task['title']),
              subtitle: Text(task['done'] ? 'Completed' : 'In progress'),
            ),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () => setState(() => currentIndex = 1),
          icon: const Icon(Icons.add_task),
          label: const Text('Manage All Tasks'),
        ),
      ],
    );
  }

  Widget statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  // TASK PAGE
  Widget taskPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Daily Tasks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: addTask,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ],
          ),
        ),
        Expanded(
          child: tasks.isEmpty
              ? const Center(child: Text('No tasks yet. Add a new task!'))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final done = task['done'] as bool;

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      child: CheckboxListTile(
                        value: done,
                        activeColor: purple,
                        title: Text(
                          task['title'],
                          style: TextStyle(
                            decoration: done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(done ? 'Completed' : 'Pending'),
                        onChanged: (value) {
                          setState(() {
                            tasks[index]['done'] = value ?? false;
                          });
                        },
                        secondary: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() => tasks.removeAt(index));
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void addTask() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create New Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter task name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  tasks.add({
                    'title': controller.text.trim(),
                    'done': false,
                  });
                });
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // PROFILE PAGE
  Widget profilePage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [purple, Color(0xFF9B72CF)],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60, color: purple),
              ),
              const SizedBox(height: 15),
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'To-Do App Member',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'Personal Information',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        profileTile(Icons.person_outline, 'Full Name', widget.name),
        profileTile(Icons.email_outlined, 'Email Address', widget.email),
        profileTile(Icons.phone_outlined, 'Phone Number', 'Not provided'),
        profileTile(
          Icons.location_on_outlined,
          'Location',
          'Tamil Nadu, India',
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ),
      ],
    );
  }

  Widget profileTile(IconData icon, String title, String value) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: purple, size: 28),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
