class SearchResult {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;

  SearchResult({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.createdAt,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SearchResult(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchResult && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
