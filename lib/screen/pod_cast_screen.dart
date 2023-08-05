// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:music_app/utils/helper_widget.dart';

// import 'package:music_app/models/MusicModel.dart';
// import 'package:music_app/screen/pod_cast_detail_screen.dart';
// import 'package:music_app/screen/search_screen.dart';
// import 'package:music_app/utils/colors.dart';

// class PodCastScreen extends StatefulWidget {
//   final String? name;

//   const PodCastScreen({Key? key, this.name}) : super(key: key);

//   @override
//   PodCastScreenState createState() => PodCastScreenState();
// }

// class PodCastScreenState extends State<PodCastScreen> {
//   List<MusicModel> podCastList = [];

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
//       key: _scaffoldKey,
//       backgroundColor: mpAppBackGroundColor,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: mpAppBackGroundColor,
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: white),
//           onPressed: () {
//             _scaffoldKey.currentState!.openDrawer();
//           },
//         ),
//         elevation: 0.0,
//         title: Text(widget.name!,
//             style: boldTextStyle(color: Colors.white.withOpacity(0.9))),
//         actions: [
//           searchIconWidget(onPressed: () {
//             const SearchScreen().launch(context);
//           }),
//         ],
//       ),
//       // drawer: DrawerScreen(),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(bottom: 60),
//         child: Wrap(
//           runAlignment: WrapAlignment.spaceEvenly,
//           alignment: WrapAlignment.spaceEvenly,
//           children: List.generate(
//             podCastList.length,
//             (index) {
//               MusicModel data = podCastList[index];

//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 width: context.width() * 0.45,
//                 child: Column(
//                   children: [
//                     commonCacheImageWidget(data.img, 100,
//                             fit: BoxFit.cover, width: context.width() * 0.45)
//                         .cornerRadiusWithClipRRect(16),
//                     4.height,
//                     Text(data.title!,
//                         maxLines: 1,
//                         style: boldTextStyle(color: white.withOpacity(0.9))),
//                     4.height,
//                     Text(data.subtitle!,
//                         maxLines: 2,
//                         style: secondaryTextStyle(color: mpAppTextColor)),
//                   ],
//                 ),
//               ).onTap(() {
//                 String? img = data.img;
//                 PodCastDetailScreen(img: img).launch(context);
//               });
//             },
//           ),
//         ),
//       ),
//       // bottomNavigationBar:
//       //     SizedBox(height: 70, child: playMusicWidget(context)),
//     );
//   }
// }
