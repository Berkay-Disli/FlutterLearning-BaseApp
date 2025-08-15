class Post {
  final String id;
  final String title;
  final String subtitle;
  final String username;
  final String timestamp;
  final int replyCount;
  final int retweetCount;
  final int likeCount;
  final bool isLiked;
  final bool isRetweeted;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.username,
    required this.timestamp,
    this.replyCount = 0,
    this.retweetCount = 0,
    this.likeCount = 0,
    this.isLiked = false,
    this.isRetweeted = false,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      username: json['username'] ?? '',
      timestamp: json['timestamp'] ?? '',
      replyCount: json['reply_count'] ?? 0,
      retweetCount: json['retweet_count'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
      isRetweeted: json['is_retweeted'] ?? false,
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'username': username,
      'timestamp': timestamp,
      'reply_count': replyCount,
      'retweet_count': retweetCount,
      'like_count': likeCount,
      'is_liked': isLiked,
      'is_retweeted': isRetweeted,
      'image_url': imageUrl,
    };
  }

  Post copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? username,
    String? timestamp,
    int? replyCount,
    int? retweetCount,
    int? likeCount,
    bool? isLiked,
    bool? isRetweeted,
    String? imageUrl,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      username: username ?? this.username,
      timestamp: timestamp ?? this.timestamp,
      replyCount: replyCount ?? this.replyCount,
      retweetCount: retweetCount ?? this.retweetCount,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      isRetweeted: isRetweeted ?? this.isRetweeted,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
