import 'package:flutter/material.dart';
import '../model/model.dart';



class ToDoWidget extends StatelessWidget {
  final ToDo todo;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ToDoWidget(
      {Key? key,
      required this.todo,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
        child: Card(
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(60, 40),
                  bottomLeft: Radius.elliptical(60, 40))
          ),
          color: Colors.blue,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    todo.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                  child: Divider(
                    color: Colors.blue,
                    thickness: 2,
                  ),
                ),
                Text(todo.description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
