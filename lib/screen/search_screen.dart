// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:music_app/utils/colors.dart';

// class SearchScreen extends StatefulWidget {
//   static String tag = '/MPSearchScreen';

//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   SearchScreenState createState() => SearchScreenState();
// }

// class SearchScreenState extends State<SearchScreen> {
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   Future<void> init() async {
//     //
//   }

//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mpAppBackGroundColor,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: mpSearchBarBackGroundColor,
//         title: TextField(
//           style: primaryTextStyle(color: Colors.white),
//           cursorColor: Colors.white,
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Aýdymçy aýdymyň ady, albom ady ...',
//             hintStyle: primaryTextStyle(color: Colors.white),
//             border: InputBorder.none,
//           ),
//         ),
//         actions: [
//           const Icon(Icons.settings_voice_outlined).paddingOnly(right: 16),
//         ],
//       ),
//     );
//   }
// }
