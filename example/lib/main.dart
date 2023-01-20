import 'package:flutter/material.dart';
import 'package:launcher_entry/launcher_entry.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LauncherEntryTestPage());
  }
}

class LauncherEntryTestPage extends StatefulWidget {
  const LauncherEntryTestPage({super.key});

  @override
  State<LauncherEntryTestPage> createState() => _LauncherEntryTestPageState();
}

class _LauncherEntryTestPageState extends State<LauncherEntryTestPage> {
  bool countVisible = false;
  bool progressVisible = false;
  int count = 0;
  double progress = 0;
  bool urgent = false;
  final service = LauncherEntryService(
    'application://example.desktop',
    '/com/canonical/launcherentry/example',
  );

  @override
  Widget build(BuildContext context) {
    service.update(
      count: count,
      countVisible: countVisible,
      progress: progress,
      progressVisible: progressVisible,
      urgent: urgent,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('count visible'),
                const Spacer(),
                Checkbox(
                  value: countVisible,
                  onChanged: (value) =>
                      setState(() => countVisible = value ?? false),
                )
              ],
            ),
            Row(
              children: [
                const Text('progress visible'),
                const Spacer(),
                Checkbox(
                  value: progressVisible,
                  onChanged: (value) =>
                      setState(() => progressVisible = value ?? false),
                )
              ],
            ),
            Row(
              children: [
                const Text('urgent'),
                const Spacer(),
                Checkbox(
                  value: urgent,
                  onChanged: (value) => setState(() => urgent = value ?? false),
                )
              ],
            ),
            Row(
              children: [
                const Text('count'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => setState(() => count++),
                  child: const Text('+'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => count--),
                  child: const Text('-'),
                ),
              ],
            ),
            Row(
              children: [
                const Text('progress'),
                const Spacer(),
                Slider(
                  value: progress,
                  min: 0,
                  max: 1,
                  onChanged: (value) => setState(() => progress = value),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
