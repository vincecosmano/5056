class Note {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final String folder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool syncedToCloud;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.folder,
    required this.createdAt,
    required this.updatedAt,
    this.syncedToCloud = false,
  });
}