import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/models/admin.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool _initialized = false;
  DropdownList _dropdownList;
  String registeredUsers, verifiedMale, verifiedFemale, marriedUsers;
  String mBanten, mJabo, mJabar, mJateng, mDiy, mJatim;
  String fBanten, fJabo, fJabar, fJateng, fDiy, fJatim;
  String cBanten, cJabo, cJabar, cJateng, cDiy, cJatim;

  countRegistered() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection('users').getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      registeredUsers = _snapshot.length.toString();
      debugPrint("Registered users: $registeredUsers");
    });
  }

  countVerifiedMale() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      verifiedMale = _snapshot.length.toString();
      debugPrint("Verified male: $verifiedMale");
    });
  }

  countVerifiedFemale() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      verifiedFemale = _snapshot.length.toString();
      debugPrint("Verified female: $verifiedFemale");
    });
  }

  countMarried() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      marriedUsers = _snapshot.length.toString();
      debugPrint("Married users: $marriedUsers");
    });
  }

  countMaleBanten() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Banten')
        .where('gender', isEqualTo: 'gentleman')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      mBanten = _snapshot.length.toString();
      debugPrint("Male from Banten: $mBanten");
    });
  }

  countFemaleBanten() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Banten')
        .where('gender', isEqualTo: 'lady')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      fBanten = _snapshot.length.toString();
      debugPrint("Female from Banten: $fBanten");
    });
  }

  countCoupleBanten() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .where('province', isEqualTo: 'Banten')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      cBanten = _snapshot.length.toString();
      debugPrint("Couple from Banten: $cBanten");
    });
  }

  countMaleJabo() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jabodetabek')
        .where('gender', isEqualTo: 'gentleman')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      mJabo = _snapshot.length.toString();
      debugPrint("Male from Jabo: $mJabo");
    });
  }

  countFemaleJabo() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jabodetabek')
        .where('gender', isEqualTo: 'lady')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      fJabo = _snapshot.length.toString();
      debugPrint("Female from Jabo: $fJabo");
    });
  }

  countCoupleJabo() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .where('province', isEqualTo: 'Jabodetabek')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      cJabo = _snapshot.length.toString();
      debugPrint("Couple from Jabo: $cJabo");
    });
  }

  countMaleJabar() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jawa Barat')
        .where('gender', isEqualTo: 'gentleman')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      mJabar = _snapshot.length.toString();
      debugPrint("Male from Jabar: $mJabar");
    });
  }

  countFemaleJabar() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jawa Barat')
        .where('gender', isEqualTo: 'lady')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      fJabar = _snapshot.length.toString();
      debugPrint("Female from Jabar: $fJabar");
    });
  }

  countCoupleJabar() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .where('province', isEqualTo: 'Jawa Barat')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      cJabar = _snapshot.length.toString();
      debugPrint("Couple from Jabar: $cJabar");
    });
  }

  countMaleJateng() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jawa Tengah')
        .where('gender', isEqualTo: 'gentleman')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      mJateng = _snapshot.length.toString();
      debugPrint("Male from Jateng: $mJateng");
    });
  }

  countFemaleJateng() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jawa Tengah')
        .where('gender', isEqualTo: 'lady')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      fJateng = _snapshot.length.toString();
      debugPrint("Female from Jateng: $fJateng");
    });
  }

  countCoupleJateng() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .where('province', isEqualTo: 'Jawa Tengah')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      cJateng = _snapshot.length.toString();
      debugPrint("Couple from Jateng: $cJateng");
    });
  }

  countMaleJatim() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jawa Timur')
        .where('gender', isEqualTo: 'gentleman')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      mJatim = _snapshot.length.toString();
      debugPrint("Male from Jatim: $mJatim");
    });
  }

  countFemaleJatim() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'Jawa Timur')
        .where('gender', isEqualTo: 'lady')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      fJatim = _snapshot.length.toString();
      debugPrint("Female from Jatim: $fJatim");
    });
  }

  countCoupleJatim() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .where('province', isEqualTo: 'Jawa Timur')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      cJatim = _snapshot.length.toString();
      debugPrint("Couple from Jatim: $cJatim");
    });
  }

  countMaleDiy() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'DIY')
        .where('gender', isEqualTo: 'gentleman')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      mDiy = _snapshot.length.toString();
      debugPrint("Male from DIY: $mDiy");
    });
  }

  countFemaleDiy() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: 'DIY')
        .where('gender', isEqualTo: 'lady')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      fDiy = _snapshot.length.toString();
      debugPrint("Female from DIY: $fDiy");
    });
  }

  countCoupleDiy() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'married')
        .where('province', isEqualTo: 'DIY')
        .getDocuments();
    List<DocumentSnapshot> _snapshot = _myDoc.documents;
    setState(() {
      cDiy = _snapshot.length.toString();
      debugPrint("Couple from DIY: $cDiy");
    });
  }

  @override
  void initState() {
    _dropdownList = DropdownList();
    countRegistered();
    countVerifiedMale();
    countVerifiedFemale();
    countMarried();
    countMaleBanten();
    countFemaleBanten();
    countCoupleBanten();
    countMaleJabo();
    countFemaleJabo();
    countCoupleJabo();
    countMaleJabar();
    countFemaleJabar();
    countCoupleJabar();
    countMaleJateng();
    countFemaleJateng();
    countCoupleJateng();
    countMaleJatim();
    countFemaleJatim();
    countCoupleJatim();
    countMaleDiy();
    countFemaleDiy();
    countCoupleDiy();
    super.initState();

    // Schedule function call after the widget is ready to display
    WidgetsBinding.instance?.addPostFrameCallback((_) => _initialize());
  }

  void _initialize() {
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Check that the widget is still mounted
        setState(() => _initialized = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: primary1),
          const SizedBox(height: 20),
          HeaderFourText(text: "Fetching data...", color: primaryBlack),
        ],
      );
    }
    final List totalNumbers = [
      registeredUsers,
      verifiedMale,
      verifiedFemale,
      marriedUsers,
    ];
    final List icons = [
      const AssetImage("assets/images/registered.png"),
      const AssetImage("assets/images/man.png"),
      const AssetImage("assets/images/woman.png"),
      const AssetImage("assets/images/marriage.png"),
    ];
    final List maleNumbers = [
      mBanten,
      mJabo,
      mJabar,
      mJateng,
      mDiy,
      mJatim,
    ];
    final List femaleNumbers = [
      fBanten,
      fJabo,
      fJabar,
      fJateng,
      fDiy,
      fJatim,
    ];
    final List marriedNumbers = [
      cBanten,
      cJabo,
      cJabar,
      cJateng,
      cDiy,
      cJatim,
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGrey1,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 5),
                  child: HeaderOneText(
                      text: "User Statistics", color: primaryBlack),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _dropdownList.titles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: thirdBlack),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            maxRadius: 27,
                            backgroundColor: white,
                            backgroundImage: icons[index],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              HeaderTwoText(
                                  text: totalNumbers[index],
                                  color: primaryBlack),
                              ChatText(
                                text: _dropdownList.titles[index],
                                color: thirdBlack,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: HeaderTwoText(
                      text: "Provincial Breakdown", color: primaryBlack),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _dropdownList.provinceList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: thirdBlack),
                          ),
                          child: HeaderThreeText(
                              text: _dropdownList.provinceList[index],
                              color: primaryBlack),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 17),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: thirdBlack),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  HeaderTwoText(
                                      text: maleNumbers[index],
                                      color: primaryBlack),
                                  ChatText(
                                      text: "Male Users", color: thirdBlack),
                                ],
                              ),
                              Column(
                                children: [
                                  HeaderTwoText(
                                      text: femaleNumbers[index],
                                      color: primaryBlack),
                                  ChatText(
                                      text: "Female Users", color: thirdBlack),
                                ],
                              ),
                              Column(
                                children: [
                                  HeaderTwoText(
                                      text: marriedNumbers[index],
                                      color: primaryBlack),
                                  ChatText(
                                      text: "Married Users", color: thirdBlack),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
