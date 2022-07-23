import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/models/user.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DropdownList _dropdownList;

  @override
  void initState() {
    _dropdownList = DropdownList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List titles = [
      "Registered Users",
      "Verified Male Users",
      "Verified Female Users",
      "Users with Successful Marriage",
    ];
    final List totalNumbers = [
      "19031",
      "4203",
      "4255",
      "145",
    ];
    final List icons = [
      primary1,
      primary1,
      primary1,
      primary1,
    ];
    final List maleNumbers = [
      "0",
      "123",
      "0",
      "0",
      "0",
      "0",
    ];
    final List femaleNumbers = [
      "0",
      "134",
      "0",
      "0",
      "0",
      "0",
    ];
    final List marriedNumbers = [
      "0",
      "134",
      "0",
      "0",
      "0",
      "0",
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
                  itemCount: titles.length,
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
                            backgroundColor: icons[index],
                            maxRadius: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              HeaderTwoText(
                                  text: totalNumbers[index],
                                  color: primaryBlack),
                              ChatText(
                                text: titles[index],
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
