import 'package:esyryt_final_app/diary/DairyHomeScreen.dart';
import 'package:esyryt_final_app/notesScreen/NoteScreen1.dart';
import 'package:esyryt_final_app/startingPage/introductoryPage.dart';
import 'package:esyryt_final_app/todo/dashBoard.dart';
import 'package:esyryt_final_app/todoScreens/todoScreen1.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  // final ValueNotifier<String> pageTitle = ValueNotifier("Message");

  final pages = [
    DashBoard(),
    TodoScreen1(),
    NoteScreen1(),
    DairyHomeScreen(),
  ];

  // final titles = const [
  //   'Messages',
  //   'Notification',
  //   // 'Call',
  //   // 'Contacts',
  // ];

  void handelNavigation(index) {
    setState(() {
      pageIndex.value = index;
      // pageTitle.value = titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   // leading: Padding(
        //   //     padding: const EdgeInsets.only(left: 20),
        //   //     child: Avatar.small(url: Helper.randomPicUrl())),
        //   title: ValueListenableBuilder(
        //     valueListenable: pageTitle,
        //     builder: (BuildContext context, String value, _) {
        //       return Center(
        //         child: Text(
        //           value,
        //           style: TextStyle(color: Colors.blueGrey),
        //         ),
        //       );
        //     },
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 10.0),
        //       child: IconBackground(
        //           icon: Icons.search,
        //           iconColour: Colors.grey,
        //           iconSize: 32,
        //           onTap: () {
        //             print('search here');
        //           }),
        //     ),
        //   ],
        // ),
        body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedIndex: handelNavigation,
        ),
        // bottomNavigationBar: Container(
        //   height: 55,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(25),
        //       topRight: Radius.circular(25),
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black54,
        //         offset: Offset(0, 1),
        //         blurRadius: 6,
        //         spreadRadius: 2,
        //       ),
        //     ],
        //     color: Colors.white,
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(5.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         Column(
        //           children: [
        //             Icon(
        //               Icons.home_filled,
        //               size: 30,
        //               color: Color.fromARGB(255, 3, 45, 79),
        //             ),
        //             Text(
        //               "DashBoard",
        //               style: TextStyle(
        //                 fontSize: 9,
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Icon(
        //               Icons.assignment_outlined,
        //               size: 30,
        //               color: Colors.black,
        //             ),
        //             Text(
        //               "To Do",
        //               style: TextStyle(
        //                 fontSize: 9,
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Icon(
        //               Icons.sticky_note_2_sharp,
        //               size: 30,
        //               color: Colors.black,
        //             ),
        //             Text(
        //               "Notes",
        //               style: TextStyle(
        //                 fontSize: 9,
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Icon(
        //               Icons.book_outlined,
        //               size: 30,
        //               color: Colors.black,
        //             ),
        //             Text(
        //               "Diary",
        //               style: TextStyle(
        //                 fontSize: 9,
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class BottomNavigationBar extends StatefulWidget {
  ValueChanged<int> selectedIndex;
  BottomNavigationBar({required this.selectedIndex});
  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  int selectedIndex = 0;
  void handelItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.selectedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationBarItem(
              index: 0,
              icon: Icons.home_filled,
              label: "DashBoard",
              isSelected: (selectedIndex == 0),
              ontap: handelItem,
            ),
            NavigationBarItem(
              index: 1,
              icon: Icons.assignment_outlined,
              label: 'To Do',
              isSelected: (selectedIndex == 1),
              ontap: handelItem,
            ),
            NavigationBarItem(
              index: 2,
              icon: Icons.sticky_note_2_sharp,
              isSelected: (selectedIndex == 2),
              label: 'Notes',
              ontap: handelItem,
            ),
            NavigationBarItem(
              index: 3,
              icon: Icons.book_outlined,
              isSelected: (selectedIndex == 3),
              label: 'Diary',
              ontap: handelItem,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatefulWidget {
  String label;
  IconData icon;
  int index;
  bool isSelected = false;
  ValueChanged<int> ontap;
  NavigationBarItem({
    required this.label,
    required this.icon,
    required this.index,
    required this.ontap,
    required this.isSelected,
  });

  @override
  State<NavigationBarItem> createState() => _NavigationBarItemState();
}

class _NavigationBarItemState extends State<NavigationBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.ontap(widget.index),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? const Color.fromARGB(255, 4, 74, 132)
                  : Color.fromARGB(255, 3, 45, 79),
              size: 30,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.label,
              style: widget.isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 74, 132))
                  : const TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
