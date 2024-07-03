// Topic model
class Topic {
  final String id;
  final String topicName;

  Topic({
    required this.id,
    required this.topicName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'topicName': topicName,
    };
  }

  static Topic fromMap(Map<String, dynamic> map) => Topic(
        id: map['id'] as String,
        topicName: map['topicName'] as String,
      );
}

class Article {
  final String id;
  final String topicId;
  final String writerId;
  final String title;
  final String? imageUrl;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.id,
    required this.topicId,
    required this.writerId,
    required this.title,
    this.imageUrl,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'topicId': topicId,
      'writerId': writerId,
      'title': title,
      'imageUrl': imageUrl,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static Article fromMap(Map<String, dynamic> map) => Article(
        id: map['id'] as String,
        topicId: map['topicId'] as String,
        writerId: map['writerId'] as String,
        title: map['title'] as String,
        imageUrl: map['imageUrl'] as String?,
        content: map['content'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
      );
}

class Comment {
  final String id;
  final String articleId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.articleId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'articleId': articleId,
      'userId': userId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static Comment fromMap(Map<String, dynamic> map) => Comment(
        id: map['id'] as String,
        articleId: map['articleId'] as String,
        userId: map['userId'] as String,
        content: map['content'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
      );
}

class Vote {
  final String id;
  final String articleId;
  final String userId;
  final String voteType; // "up" or "down"

  Vote({
    required this.id,
    required this.articleId,
    required this.userId,
    required this.voteType,
  });

  // Additional methods like fromMap and toMap for serialization (optional)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'articleId': articleId,
      'userId': userId,
      'voteType': voteType,
    };
  }

  static Vote fromMap(Map<String, dynamic> map) => Vote(
        id: map['id'] as String,
        articleId: map['articleId'] as String,
        userId: map['userId'] as String,
        voteType: map['voteType'] as String,
      );
}
