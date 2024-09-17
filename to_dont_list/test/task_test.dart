import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/task.dart';

void main() {
    
    test('abbrev() returns an empty string for empty task name', () {
      const task = Task(name: '');
      expect(task.abbrev(), '');
    });

    test('update() creates a new Task with updated values', () {
      const task = Task(name: 'Complete project', rating: 4);

      final updatedTask = task.update(
        rating: 5,
        description: 'Finished early',
        wouldDoAgain: true,
      );

      expect(updatedTask.name, 'Complete project'); 
      expect(updatedTask.rating, 5); 
      expect(updatedTask.description, 'Finished early'); 
      expect(updatedTask.wouldDoAgain, true); 
    });

    test('update() keeps previous values when new ones are null', () {
      const task = Task(
        name: 'Go jogging',
        rating: 3,
        description: 'Morning jog',
        wouldDoAgain: true,
      );

      final updatedTask = task.update();

      expect(updatedTask.name, 'Go jogging');
      expect(updatedTask.rating, 3); 
      expect(updatedTask.description, 'Morning jog'); 
      expect(updatedTask.wouldDoAgain, true); 
    });
  }
