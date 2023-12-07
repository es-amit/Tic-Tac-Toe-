import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/widgets/constants.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Category _selectedCategory = Category.food;
  Priority _selectedPriority = Priority.low;
  DateTime? _selectedDate;
  DBHelper dbHelper = DBHelper();
  late Future<List<Todo>> allTasks;
  

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async{
    allTasks = dbHelper.getDataList();
  }

  

  void _presentDatePicker() async{

    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      initialDate: now,
      context: context, 
      firstDate: firstDate, 
      lastDate: now
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLength: 15,
              decoration: InputDecoration(
                hintText: "Title...",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    strokeAlign: 1.5
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    strokeAlign: 1.5
                  )
                )
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: descriptionController,
              maxLength: 60,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Description...",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    strokeAlign: 1.5
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    strokeAlign: 1.5
                  )
                )
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name.toUpperCase()))).toList(), 
                  onChanged: (value){
                    if(value ==null){
                      return;
                  }
                  setState(() {
                    _selectedCategory = value;
                    });
                  }
                ),
                const Spacer(),
                DropdownButton(
                  value: _selectedPriority,
                  items: Priority.values.map(
                    (priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(
                        priority.name.toUpperCase()))).toList(), 
                  onChanged: (value){
                    if(value == null){
                      return;
                  }
                  setState(() {
                    _selectedPriority = value;
                    });
                  }
                ),
                const Spacer(),
                Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: (){
                      _presentDatePicker();
                    },
                    icon: const Icon(Icons.calendar_month)),
                    Text(_selectedDate == null ? "No date Selected" : formatter.format(_selectedDate!)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(hintText: 'Cancel', containerColor: Colors.redAccent,nextScreen: (){
                  Navigator.pop(context);
                }),
                const SizedBox(width: 10,),
                CustomButton(hintText: "Add New Task",containerColor: Colors.green,nextScreen: (){
                  try{
                    dbHelper.insert(Todo(
                      title: titleController.text, 
                      description: descriptionController.text, 
                      // date: _selectedDate!, 
                      taskPriority: _selectedPriority, 
                      category: _selectedCategory, 
                      status: false
                      )
                    );
                    print('inserted data'); 
                    Navigator.pop(context);
                  }
                  catch(e){
                    print("insert error");
                  }
                },)
              ],
            )
          ],
        ),
      ),
    );
  }

}