import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  success() {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];
        List<bool> isChecked =
            List.generate(controller.todos.length, (index) => false);

        // bool checke = true;
        return ListTile(
          title: Text(todo.title.toString()),
          trailing: Checkbox(
              activeColor: Colors.green,
              //value: isChecked[index],
              onChanged: (value) {
                setState(
                  () {
                    isChecked[index] = value!;
                  },
                );
              },
              value: isChecked[index]),
        );
      },
    );
  }

  error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        child: const Text('Try again!'),
      ),
    );
  }

  loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return start();
      case HomeState.loading:
        return loading();
      case HomeState.error:
        return error();
      case HomeState.success:
        return success();
      default:
        return start();
    }
  }

  @override
  void initState() {
    super.initState();

    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Todo\'s'),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List todo = [];
//   Future getTodos() async {
//     String url = 'https://jsonplaceholder.typicode.com/todos';
//     var response = await http.get(Uri.parse(url));
//     var responsebody = jsonDecode(response.body);
//     // print(responsebody[2]);

//     setState(() {
//       todo.addAll(responsebody);
//     });
//   }

//   @override
//   void initState() {
//     getTodos();
//     super.initState();
//   }

//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: todo.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('${todo[index]['title']}'),
//             trailing: Checkbox(
//               activeColor: Colors.amber,
//               checkColor: Colors.red,
//               value: todo[index]['competed'],
//               onChanged: (value) {
//                 setState(() {
//                   todo[index]['title'] = value!;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
