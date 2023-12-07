import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/screen/new_todo_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<Todo>> allTasks;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async{
    allTasks = dbHelper!.getDataList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo list"),
      ),
      body: FutureBuilder(
        future: allTasks, 
        builder: (context,AsyncSnapshot<List<Todo>> snapshot){
          if(!snapshot.hasData || snapshot.data == null){
            print(snapshot.error);
            return Center(
              child: Text('chutiya'),
            );
          }
          else if(snapshot.data!.length == 0){
            return Center(
              child: Text("No tasks available"),
            );
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 6,
                  color: Colors.greenAccent,
                  child: ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].description),
                    trailing: Text(snapshot.data![index].category.name),        
                  ),
                );
              }));

          }
        })
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const  NewTask()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}