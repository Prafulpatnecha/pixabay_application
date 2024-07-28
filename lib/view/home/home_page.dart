import 'package:flutter/material.dart';
import 'package:pixabay_application/modal/home_modal.dart';
import 'package:pixabay_application/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue=Provider.of<HomeProvider>(context,listen: true);
    HomeProvider homeProviderFalse=Provider.of<HomeProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: homeProviderTrue.textEditingController,
              onChanged: (value) {
                homeProviderFalse.txtSearch();
              },
              onSaved: (newValue) {
                homeProviderFalse.txtSearch();
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(80)),
                prefixIcon: const Icon(Icons.search_sharp),
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(80)),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,),borderRadius: BorderRadius.circular(80)),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<HomeProvider>(context,listen: false).fetchApiData(),
            builder: (context, snapshot) {
              if(snapshot.hasData)
              {
                  ApiModal? apiModal=snapshot.data;
                  return GridView.builder(itemCount: apiModal!.hits.length,itemBuilder: (context, index) {
                    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FadeInImage.assetNetwork(placeholder: "assets/image/w200.gif",image:apiModal.hits[index].largeImageURL,fit: BoxFit.fill),
                  );
                  }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 9/16),);
                }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ],
      ),
    );
  }
}
