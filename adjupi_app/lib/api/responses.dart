class StandardResponse {
  final String status;

  StandardResponse({this.status});

  factory StandardResponse.fromJson(Map<String, dynamic> json) {
    return StandardResponse(
      status: json['status'],
    );
  }

  String serialize() {
    return status;
  }
}

class ApiResponse {
  final String project;
  final String name;
  final double version;
  final String author;

  ApiResponse({
    this.project,
    this.name,
    this.version,
    this.author,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      project: json['project'],
      name: json['name'],
      version: json['version'],
      author: json['author'],
    );
  }

  String serialize() {
    return "Project: ${this.project} \n"
        "Name: ${this.name} \n"
        "Version: ${this.version} \n"
        "Author: ${this.author}";
  }
}
