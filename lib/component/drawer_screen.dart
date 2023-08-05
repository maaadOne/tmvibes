// import 'package:flutter/material.dart';
// import 'package:music_app/modules/album/views/album_view.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:music_app/models/MusicModel.dart';
// import 'package:music_app/utils/colors.dart';

// import '../screen/play_list_screen.dart';

// class DrawerScreen extends StatefulWidget {
//   const DrawerScreen({Key? key}) : super(key: key);

//   @override
//   DrawerScreenState createState() => DrawerScreenState();
// }

// class DrawerScreenState extends State<DrawerScreen> {
//   List<DrawerList> drawerList = [
//     // DrawerList(name: "Songs", widget: const SongsScreen()),
//     // DrawerList(name: "Artists", widget: const ArtistsScreen(name: 'Artists')),
//     DrawerList(name: "Albums", widget: AlbumView(isTab: false)),
//     DrawerList(name: "Playlist", widget: const PlayListScreen()),
//   ];

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
//     return Theme(
//       data: ThemeData(canvasColor: mpAppBackGroundColor),
//       child: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             Container(
//               color: mpAppBackGroundColor,
//               padding: const EdgeInsets.only(bottom: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: drawerList.map((e) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(e.name!, style: primaryTextStyle(color: white))
//                               .paddingAll(8),
//                           const Divider(color: mpAppTextColor1),
//                         ],
//                       ).onTap(() {
//                         finish(context);
//                         e.widget.launch(context);
//                       });
//                     }).toList(),
//                   ).paddingAll(8),
//                   16.height,
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
