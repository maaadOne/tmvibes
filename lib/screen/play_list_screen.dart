// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:music_app/utils/helper_widget.dart';
// import 'package:music_app/models/MusicModel.dart';
// import 'package:music_app/screen/play_list_detail_screen.dart';
// import 'package:music_app/screen/search_screen.dart';
// import 'package:music_app/utils/colors.dart';

// class PlayListScreen extends StatefulWidget {
//   static String tag = '/MPPlayListScreen';

//   const PlayListScreen({Key? key}) : super(key: key);

//   @override
//   PlayListScreenState createState() => PlayListScreenState();
// }

// class PlayListScreenState extends State<PlayListScreen> {
//   List<MusicModel> playList = [];

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
//         backgroundColor: mpAppBackGroundColor,
//         title: Text('My Playlist',
//             style: boldTextStyle(color: white.withOpacity(0.9), size: 18)),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_outlined, color: white.withOpacity(0.9)),
//           onPressed: () {
//             finish(context);
//           },
//         ),
//         automaticallyImplyLeading: true,
//         iconTheme: IconThemeData(color: white.withOpacity(0.9)),
//         actions: [
//           searchIconWidget(onPressed: () {
//             const SearchScreen().launch(context);
//           }),
//         ],
//         elevation: 0.0,
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           SingleChildScrollView(
//             child: Wrap(
//               runSpacing: 4,
//               spacing: 16,
//               runAlignment: WrapAlignment.spaceEvenly,
//               alignment: WrapAlignment.center,
//               children: List.generate(
//                 playList.length,
//                 (index) {
//                   MusicModel data = playList[index];

//                   return SizedBox(
//                     width: context.width() * 0.45,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         commonCacheImageWidget(data.img, 170, fit: BoxFit.cover)
//                             .cornerRadiusWithClipRRect(10)
//                             .onTap(() {
//                           PlayListDetailScreen(data: data).launch(context);
//                         }),
//                         4.height,
//                         Text(data.title!,
//                             style: primaryTextStyle(color: Colors.white),
//                             maxLines: 1),
//                         4.height,
//                         Text(data.subtitle!,
//                             style: secondaryTextStyle(
//                                 color: Colors.white.withOpacity(0.5)),
//                             maxLines: 1),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ).paddingOnly(bottom: 70),
//           ),
//           // Positioned(
//           //     bottom: 0, left: 0, right: 0, child: playMusicWidget(context)),
//         ],
//       ),
//     );
//   }
// }
