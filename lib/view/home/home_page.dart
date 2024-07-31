import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pixabay_application/modal/home_modal.dart';
import 'package:pixabay_application/provider/home_provider.dart';
import 'package:provider/provider.dart';

GlobalKey imageKey = GlobalKey();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider homeProviderFalse =
        Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: homeProviderTrue.textEditingController,
              onChanged: (value) {
                homeProviderFalse.txtSearch();
              },
              onSaved: (newValue) {
                homeProviderFalse.txtSearch();
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(80)),
                prefixIcon: const Icon(Icons.search_sharp),
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(80)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(80)),
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<HomeProvider>(context, listen: false)
                .fetchApiData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                homeProviderTrue.apiModalSnap=snapshot.data;
                ApiModal? apiModal = snapshot.data;
                return GridView.builder(
                  itemCount: apiModal!.hits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              homeProviderFalse.indexSelectingMethod(index);
                              Navigator.of(context).pushNamed('/wallpaper');
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.pink.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage("assets/image/w200.gif"),
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.contain,
                                  image: NetworkImage(
                                    apiModal.hits[index].largeImageURL,
                                  ),
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(tileMode: TileMode.mirror),
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.blue.withOpacity(0),
                                        backgroundImage: NetworkImage(apiModal.hits[index].userImageURL),
                                      ),
                                      const SizedBox(width: 5,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(apiModal.hits[index].user.toString(),style: const TextStyle(color: Colors.white),),
                                          // Text("Likes : ${apiModal.hits[index].likes}",style: TextStyle(color: Colors.white),),
                                          Text("Views : ${apiModal.hits[index].views}",style: const TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 9 / 16),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
