class ToDo{
  final int? id;
  final String title;
  final String description;


  const ToDo({required this.title, required this.description, this.id});

  factory ToDo.fromJson(Map<String,dynamic> json) => ToDo(
    id: json['id'],
    title: json['title'],
    description: json['description']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description
  };

}