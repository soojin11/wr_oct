// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wr_ui/service/dark_white_mode/mode.dart';
// import 'package:wr_ui/view/appbar/actions/minimize/window_btn.dart';
// import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
// import 'package:wr_ui/view/appbar/leading/clock.dart';
// import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
// import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
// import 'package:wr_ui/view/chart/pages/ADDpage.dart';
// import 'package:wr_ui/view/chart/pages/ALLpage.dart';
// import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
// import 'package:wr_ui/view/chart/pages/OESpage.dart';
// import 'package:wr_ui/view/chart/pages/VIpage.dart';
// import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
// import 'package:wr_ui/view/right_side_menu/exit_btn.dart';
// import 'package:wr_ui/view/right_side_menu/start_stop.dart';

// import 'controller/home_controller.dart';
// import 'view/appbar/actions/setting/recipe_menu_final.dart';
// import 'view/right_side_menu/log_screen.dart';

// class Home extends StatelessWidget{
//    Home({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: WRappbar(),
//     body: WRbody()
//     );}

// }

// class WRappbar extends StatelessWidget implements PreferredSizeWidget{
//   WRappbar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Size get preferredSize => Size.fromHeight(70);
//   final themeController = Get.put(HomeController());

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16),
//       child: Container(
//         child: AppBar(
//             automaticallyImplyLeading: true,
//             // backgroundColor: Theme.of(context).backgroundColor,
//             leading: TextButton(
//               onPressed: () {
//                 Get.to(() => Home());
//               },
//               child: Image.asset(
//                 'assets/images/CI_nobg.png',
//                 scale: 10,
//               ),
//             ),
//             actions: [
//               Container(
//                 width: 600,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 100,
//                     ),
//                     Clock(),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     RecentRecipeName(),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     RunErrorStatus(),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               SettingMenu(),
//               SizedBox(
//                 width: 50,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   ThemeService().switchTheme();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Icon(
//                       Get.isDarkMode
//                           ? Icons.toggle_off_outlined
//                           : Icons.toggle_on_outlined,
//                       size: 40),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               WindowButtons(),
//             ]),
//       ),
//     );
//   }
// }

// class WRbody extends StatelessWidget {
//   const WRbody({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       //////////////////////////차트공간
//       Expanded(
//         flex: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2), //그림자 색
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 2), // 그림자위치 바꾸는거
//                 ),
//               ],
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Container(
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(10)),
//               //////////////차트 컨테이너 내에 페이지 이동
//               child: GetMaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 theme: ThemeData(
//                     textTheme: TextTheme(
//                       bodyText2: TextStyle(color: Colors.black),
//                     ),
//                     scaffoldBackgroundColor: Colors.transparent),
//                 initialRoute: '/all',
//                 routes: {
//                   '/all': (context) => ALLpage(),
//                   '/oes': (context) => OESpage(),
//                   '/vi': (context) => VIpage(),
//                   '/custom': (context) => CUSTOMpage(),
//                   '/add': (context) => ADDpage(),
//                 },
//               ),
//               //////////////차트 컨테이너 내에 페이지 이동
//               // CahrtDropDown(),
//             ),
//           ),
//         ),
//       ),

//       Expanded(
//           flex: 1,
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   //////////로그
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               'Log View',
//                               style: TextStyle(
//                                 color: Colors.blueGrey[800],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(
//                           indent: 10,
//                           endIndent: 10,
//                         ),
//                         LogList()
//                       ],
//                     ),
//                   ),
//                   //////////로그
//                   //////////스타트스탑리셋
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 'Chart Start / Stop',
//                                 style: TextStyle(
//                                   color: Colors.blueGrey[800],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             indent: 10,
//                             endIndent: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               StartStop(),
//                             ],
//                           ),
//                           //////////////스타트스탑리셋
//                         ],
//                       ),
//                     ),
//                   ), //////////////파일매니저
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 'Save File',
//                                 style: TextStyle(
//                                   color: Colors.blueGrey[800],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             indent: 10,
//                             endIndent: 10,
//                           ),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CSVButton(),
//                                 // iniBtn(),
//                                 // TxtBtn(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   /////////////파일매니저
//                   /////////////레시피버튼
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 'Recipe',
//                                 style: TextStyle(
//                                   color: Colors.blueGrey[800],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             indent: 10,
//                             endIndent: 10,
//                           ),
//                           RecipeMenu()
//                         ],
//                       ),
//                     ),
//                   ),
//                   /////////////레시피버튼
//                   ////////////나가기
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 'Exit',
//                                 style: TextStyle(
//                                   color: Colors.blueGrey[800],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             indent: 10,
//                             endIndent: 10,
//                           ),
//                           ExitBtn()
//                         ],
//                       ),
//                     ),
//                   )
//                   ////////////나가기
//                 ],
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2), //그림자 색
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 2), // 그림자위치 바꾸는거
//                 ),
//               ],
//             ),
//           ))
//     ],
//     );
//   }
// }