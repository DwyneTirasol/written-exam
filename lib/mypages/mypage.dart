import 'package:flutter/material.dart';
import '../dbhelper/dbhelper.dart';
import '../model/model.dart';
import '../widget/widget.dart';
import 'formhandling.dart';



class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text('My List'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ToDoListFormHandling()));
            setState(() {});
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, color: Colors.black),
        ),
        body: FutureBuilder<List<ToDo>?>(
          future: ToDoDataBaseHelper.getAllToDo(),
          builder: (context, AsyncSnapshot<List<ToDo>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => ToDoWidget(
                    todo: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ToDoListFormHandling(todo: snapshot.data![index])));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                  topRight: Radius.elliptical(60, 40),
                                  bottomLeft: Radius.elliptical(60, 40))),
                              backgroundColor: Colors.blue,
                              title: const Text(
                                  'Do you want to delete this task?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue)),
                                  onPressed: () async {
                                    await ToDoDataBaseHelper.deleteTodo(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('There is no task'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
