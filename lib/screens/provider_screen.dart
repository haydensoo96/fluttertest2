
import 'package:core_flutter/provider/TodoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatefulWidget {
  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditor = TextEditingController();
          final TextEditingController _textEditor2 = TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditor,
                        validator: (noteTitle) {
                          return noteTitle!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration: InputDecoration(hintText: 'Enter title'),
                      ),
                      TextFormField(
                        controller: _textEditor2,
                        validator: (noteDetails) {
                          return noteDetails!.isNotEmpty
                              ? null
                              : "Invalid Field";
                        },
                        decoration: InputDecoration(hintText: 'Enter details'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Choice Box'),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked!;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      Provider.of<TodoModel>(context)
                          .addTaskList(context,_textEditor.text, _textEditor2.text);
                    }
                  },
                )
              ],
            );
          });
        });
  }

  @override
  Widget build(context) {
    return Scaffold(
        // ignore: unnecessary_brace_in_string_interps
        appBar: AppBar(title: Text("Provider")),
        body: Column(
          children: <Widget>[

            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50))),
                    child: Consumer<TodoModel>(builder: (context, todo, child) {
                      return ListView.builder(
                          itemCount: todo.taskList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 32, right: 32, top: 8, bottom: 8),
                                title: Text(
                                  'Task Name: ${todo.taskList[index].title}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Detail:  ${todo.taskList[index].detail}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.check_circle,
                                    color: Colors.greenAccent),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: 8, left: 16, right: 16),
                            );
                          });
                    })))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await showInformationDialog(context);
            }));
  }
}
