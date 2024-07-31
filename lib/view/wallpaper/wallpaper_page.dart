
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_application/provider/home_provider.dart';
import 'package:provider/provider.dart';

class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider homeProviderFalse =
        Provider.of<HomeProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
            key: homeProviderTrue.imageKey,
            child: SizedBox(
              width: width,
              height: height,
              child: FadeInImage(
                image: NetworkImage(homeProviderTrue
                    .apiModal.hits[homeProviderTrue.selectIndex].largeImageURL),
                placeholderFit: BoxFit.contain,
                placeholder: const AssetImage("assets/image/w200.gif"),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: width,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      color: Colors.white,
                      onPressed: () {
                        homeProviderFalse.imageDownloadMethod();
                      },
                      icon: const Icon(
                        Icons.downloading_sharp,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      color: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                          scrollControlDisabledMaxHeightRatio: 0.2,
                          backgroundColor: Colors.blue.withOpacity(0.5),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: width,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      homeProviderFalse.wallpaperMethod(1);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 50,
                                      color: Colors.green.withOpacity(0),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Home Screen',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  buildDottedLine(),
                                  GestureDetector(
                                    onTap: () {
                                      homeProviderFalse.wallpaperMethod(2);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 70,
                                      color: Colors.green.withOpacity(0),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Lock Screen',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  buildDottedLine(),
                                  GestureDetector(
                                    onTap: () {
                                      homeProviderFalse.wallpaperMethod(3);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 70,
                                      color: Colors.green.withOpacity(0),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Both Screen',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.wallpaper,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  DottedLine buildDottedLine() {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Colors.black,
      dashGradient: const [Colors.red, Colors.blue],
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapGradient: const [Colors.red, Colors.blue],
      dashGapRadius: 0.0,
    );
  }
}
