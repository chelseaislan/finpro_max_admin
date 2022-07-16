// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finpro_max_admin/bloc/search_profile/search_profile_bloc.dart';
// import 'package:finpro_max_admin/bloc/search_profile/search_profile_event.dart';
// import 'package:finpro_max_admin/bloc/search_profile/search_profile_state.dart';
// import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
// import 'package:finpro_max_admin/custom_widgets/card_photo.dart';
// import 'package:finpro_max_admin/custom_widgets/empty_content.dart';
// import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
// import 'package:finpro_max_admin/models/colors.dart';
// import 'package:finpro_max_admin/models/user.dart';
// import 'package:finpro_max_admin/repositories/search_repository.dart';
// import 'package:finpro_max_admin/ui/widgets/tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class HomePage extends StatefulWidget {
//   final String adminId;
//   const HomePage({this.adminId});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final SearchRepository _searchRepository = SearchRepository();
//   SearchProfileBloc _searchProfileBloc;

//   @override
//   void initState() {
//     _searchProfileBloc = SearchProfileBloc(searchRepository: _searchRepository);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         backgroundColor: white,
//         appBar: AppBarSideButton(
//           appBarTitle: Image.asset(
//             "assets/images/header_logo.png",
//             width: size.width * 0.4,
//           ),
//           appBarColor: white,
//         ),
//         body: BlocBuilder<SearchProfileBloc, SearchProfileState>(
//           bloc: _searchProfileBloc,
//           builder: (context, state) {
//             if (state is SearchInitialState) {
//               _searchProfileBloc
//                   .add(SearchLoadUserEvent(adminId: widget.adminId));
//               return Center(child: CircularProgressIndicator(color: primary1));
//             } else if (state is SearchLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation(primary1),
//                 ),
//               );
//             } else if (state is SearchLoadUserState) {
//               return Stack(
//                 children: [
//                   StreamBuilder<QuerySnapshot>(
//                     stream: state.userList,
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return Center(
//                             child: CircularProgressIndicator(color: primary1));
//                       }
//                       if (snapshot.data.documents.isNotEmpty) {
//                         final user = snapshot.data.documents;
//                         return Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: size.width * 0.05),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 ListView.builder(
//                                   itemCount: user.length,
//                                   itemBuilder: (context, index) {
//                                     return GestureDetector(
//                                       onTap: () async {
//                                         Fluttertoast.showToast(
//                                             msg:
//                                                 "Opening ${user[index].data['nickname']}...");
//                                         User selectedUser =
//                                             await _searchRepository.getUser(
//                                                 user[index].documentID);
//                                         Admin admin = await _searchRepository
//                                             .getAdmin(widget.adminId);
//                                       },
//                                       child: ListTile(
//                                         leading: CircleAvatar(
//                                           child: CardPhotoWidget(
//                                               photoLink:
//                                                   user[index].data['photoUrl']),
//                                         ),
//                                         title: HeaderFourText(
//                                           text:
//                                               "${user[index].data['name']}, ${user[index].data['age']}",
//                                           color: secondBlack,
//                                         ),
//                                         subtitle: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             DescText(
//                                               text:
//                                                   "${user[index].data['jobPosition']} at ${user[index].data['currentJob']}",
//                                               color: thirdBlack,
//                                             ),
//                                             MiniText(
//                                                 text:
//                                                     "${user[index].data['accountType']}"
//                                                         .toUpperCase(),
//                                                 color: thirdBlack),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       } else {
//                         return SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               SizedBox(height: size.height * 0.15),
//                               EmptyContent(
//                                 size: size,
//                                 asset: "assets/images/discover-tab.png",
//                                 header: "Uh-oh...",
//                                 description:
//                                     "Looks like there is no one around. Please come back later.",
//                                 buttonText: "Refresh",
//                                 onPressed: () {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     PageRouteBuilder(
//                                       pageBuilder:
//                                           (context, animation1, animation2) =>
//                                               HomeTabs(
//                                                   adminId: widget.adminId,
//                                                   selectedPage: 0),
//                                       transitionDuration: Duration.zero,
//                                       reverseTransitionDuration: Duration.zero,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               );
//             }
//             return EmptyContent(
//               size: size,
//               asset: "assets/images/empty-container.png",
//               header: "Uh-oh...",
//               description:
//                   "The content you're looking for is not found. Please come back later.",
//               buttonText: "Refresh",
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   PageRouteBuilder(
//                     pageBuilder: (context, animation1, animation2) =>
//                         HomeTabs(adminId: widget.adminId, selectedPage: 0),
//                     transitionDuration: Duration.zero,
//                     reverseTransitionDuration: Duration.zero,
//                   ),
//                 );
//               },
//             );
//           },
//         ));
//   }
// }
