import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/provider/service_provider.dart';

class CardToDoList extends ConsumerStatefulWidget {
  const CardToDoList({super.key, required this.getIndex});

  final int getIndex;

  @override
  ConsumerState createState() => _CardToDoListState();
}

class _CardToDoListState extends ConsumerState<CardToDoList> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData1) {
        Color categoryColor = Colors.white;
        final getCategory = todoData1[widget.getIndex].category;

        switch (getCategory) {
          case "Learning":
            categoryColor = Colors.green;
            break;
          case "Working":
            categoryColor = Colors.blue.shade700;
            break;
          case "General":
            categoryColor = Colors.amber.shade700;
            break;
        }

        return Container(
          margin: EdgeInsets.all(10.0),
          // width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            ref
                                .read(serviceProvider)
                                .deleteTask(todoData1[widget.getIndex].docID);
                          },
                          icon: Icon(CupertinoIcons.delete),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          todoData1[widget.getIndex].titleTask,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: todoData1[widget.getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          overflow: TextOverflow.ellipsis,
                          todoData1[widget.getIndex].description,
                          maxLines: 3,
                          style: TextStyle(
                            decoration: todoData1[widget.getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        leading: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: todoData1[widget.getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(
                                      todoData1[widget.getIndex].docID, value)),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  Text("Today"),
                                  Gap(12),
                                  Text(todoData1[widget.getIndex].timeTask),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text("Error"),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
