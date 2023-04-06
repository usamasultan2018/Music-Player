import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../const/colors.dart';
import '../const/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                )),
          ],
          leading: Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text("Beats",
              style: ourStyle(
                size: 18,
              )),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL,
          ),
          builder: (context, snapshot) {
            // if (snapshot.data == null) {
            //   print(snapshot.data);
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else
            if (snapshot.data == null) {
              return Center(
                  child: Text(
                'No Songs Found!!',
                style: ourStyle(),
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Obx(
                            ()=> ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: bgColor,
                            title: Text(
                              '${snapshot.data![index].displayNameWOExt}',
                              style: ourStyle(
                                size: 15.0,
                              ),
                            ),
                            subtitle: Text(
                              '${snapshot.data![index].artist}',
                              style: ourStyle(
                                font: FontWeight.normal,
                                size: 12,
                              ),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Icon(Icons.music_note,color: Colors.white,size: 26,),
                            ),
                            trailing:controller.playIndex == index && controller.isPlaying.value? Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 26,
                            ):null,
                            onTap: (){

                              Get.to(()=>
                              PlayerScreen(data: snapshot.data!,),
                                transition: Transition.downToUp,
                              );
                              controller.playSongs(snapshot.data![index].uri,index);
                            },
                          ),
                        ),
                      );
                    }),
              );
            }
          },
        ));
  }
}
