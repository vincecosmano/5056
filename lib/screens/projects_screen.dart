import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  static const _statuses = ['Active', 'On Hold', 'Completed'];

  String _nextStatus(String current) {
    final idx = _statuses.indexOf(current);
    return _statuses[(idx < 0 ? 0 : idx + 1) % _statuses.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Project name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      context.read<ProjectProvider>().add(
                            Project(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: _nameController.text,
                              description: _descController.text,
                              startDate: DateTime.now(),
                              status: 'Active',
                            ),
                          );
                      _nameController.clear();
                      _descController.clear();
                    }
                  },
                  child: const Text('Add Project'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ProjectProvider>(
              builder: (context, projectProvider, child) {
                if (projectProvider.projects.isEmpty) {
                  return const Center(child: Text('No projects yet'));
                }
                return ListView.builder(
                  itemCount: projectProvider.projects.length,
                  itemBuilder: (context, index) {
                    final project = projectProvider.projects[index];
                    return ListTile(
                      title: Text(project.name),
                      subtitle: Text(project.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ActionChip(
                            label: Text(project.status),
                            tooltip: 'Change status',
                            onPressed: () {
                              projectProvider.update(Project(
                                id: project.id,
                                name: project.name,
                                description: project.description,
                                startDate: project.startDate,
                                endDate: project.endDate,
                                status: _nextStatus(project.status),
                              ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                projectProvider.delete(project.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
