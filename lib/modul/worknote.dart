class Note {
  late int id;
  late String work;
  late String isDone;

  Note({
    required this.work,
    required this.isDone,
  });

  Note.create({
    required this.id,
    required this.work,
    required this.isDone,
  });
}
