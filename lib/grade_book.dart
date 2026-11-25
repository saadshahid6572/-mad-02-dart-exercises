//Exercise 2: a grade book, built from classes.

enum Grade {
  a(85),
  b(70),
  c(55),
  d(40),
  f(0);

  const Grade(this.minAverage);

  final int minAverage;

  // TODO 3: Find the grade for an average.
  static Grade forAverage(double average) {
    for (var grade in Grade.values) {
      if (average >= grade.minAverage) {
        return grade;
      }
    }
    return Grade.f;
  }
}

class Student {
  Student(this.name);

  final String name;

  final List<int> _marks = [];

  List<int> get marks => List.unmodifiable(_marks);

  bool addMark(int mark) {
    if (mark < 0 || mark > 100) {
      return false;
    }
    _marks.add(mark);
    return true;
  }

  // TODO 4: Calculate the average.
  double? get average {
    if (_marks.isEmpty) {
      return null;
    }

    var total = _marks.reduce((a, b) => a + b);
    return total / _marks.length;
  }

  Grade? get grade {
    var currentAverage = average;
    if (currentAverage == null) {
      return null;
    }
    return Grade.forAverage(currentAverage);
  }

  @override
  String toString() {
    var currentAverage = average;
    var currentGrade = grade;

    if (currentAverage == null || currentGrade == null) {
      return '$name: no marks yet';
    }

    var text = currentAverage.toStringAsFixed(1);
    return '$name: $text (${currentGrade.name.toUpperCase()})';
  }
}

class GradeBook {
  final Map<String, Student> _students = {};

  List<Student> get students => List.unmodifiable(_students.values);

  bool addStudent(String name) {
    if (_students.containsKey(name)) {
      return false;
    }
    _students[name] = Student(name);
    return true;
  }

  // TODO 5: Find a student by name.
  Student? find(String name) {
    return _students[name];
  }

  bool addMark(String name, int mark) {
    var student = find(name);
    if (student == null) {
      return false;
    }
    return student.addMark(mark);
  }

  // TODO 6: Find the student with the highest average.
  Student? get topStudent {
    Student? bestStudent;

    for (var student in _students.values) {
      var currentAverage = student.average;

      if (currentAverage == null) {
        continue;
      }

      if (bestStudent == null || currentAverage > bestStudent.average!) {
        bestStudent = student;
      }
    }

    return bestStudent;
  }

  String report() {
    var lines = <String>[];

    for (var student in _students.values) {
      lines.add(student.toString());
    }

    var top = topStudent;
    lines.add('Top student: ${top?.name ?? 'nobody yet'}');

    return lines.join('\n');
  }
}
