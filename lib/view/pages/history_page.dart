import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_agronom_ai/core/constants/app_images.dart';
import 'package:flutter_application_agronom_ai/view/pages/camera_page.dart';
import 'package:flutter_application_agronom_ai/viewmodel/image_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.grey[100],
        backgroundColor: Color(0xfff1eee7),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 115, 207, 120),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ImagePickerPage();
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.white,
                  )),
              Text(
                "Tarix",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                    size: 24,
                  ))
            ],
          ),
        ),
        body: Consumer<ImageUploadProvider>(
          builder: (context, provider, child) {
            if (provider.isGetPredictData) {
              return Center(
                child: Text("Chatlar tarixi olib kelinmoqda"),
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    // Image.asset(
                                    //   AppImages.historyimgPng,
                                    // ),
                                    Image.network(
                                      "https://api.agronomai.birnima.uz${provider.predictData[index]['image']}",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text("Pomidor shox qurti"),
                                        // Text("03 March 2025      15:15 am"),
                                        SizedBox(
                                            height: 20,
                                            width: 200,
                                            child: Text(
                                              provider.predictData[index]
                                                  ['type']['name_uz'],
                                              maxLines: 2,
                                            )),

                                        Text(
                                            "Yaratilgan sanasi ${provider.predictData[index]['created_at'].toString().substring(0, 10)}")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
