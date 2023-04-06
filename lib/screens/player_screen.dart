import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../const/colors.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;

  const PlayerScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =  Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                  width: 300,
                  decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Icon(
                        Icons.music_note, size: 48, color: whiteColor,), 

                  )
              )),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(9),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      style: ourStyle(
                        color: bgDarkColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      style: ourStyle(
                        color: bgDarkColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          controller.position.value,
                          style: ourStyle(
                            color: bgDarkColor,
                          ),
                        ),
                        Expanded(
                            child: Slider(
                                inactiveColor: bgColor,
                                thumbColor: sliderColor,
                                min: Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value:controller.value.value,
                                onChanged: (value) {
                                  controller.checkDurationToSec(value.toInt());
                                  value = value;
                                })),
                        Text(
                          controller.duration.value,
                          style: ourStyle(
                            color: bgDarkColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.playSongs(data[controller.playIndex.value].uri, controller.playIndex.value-1);
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 40,
                              color: bgDarkColor,
                            )),
                        Obx(
                            ()=> CircleAvatar(
                              radius: 40,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 2,
                                child: IconButton(
                                    onPressed: () {
                                      if(controller.isPlaying.value){
                                        controller.audioPlayer.pause();
                                        controller.isPlaying(false);
                                      }
                                      else{
                                        controller.audioPlayer.play();
                                            controller.isPlaying(true);
                                      }
                                    },
                                    icon: controller.isPlaying.value ?  const Icon(
                                      Icons.pause,
                                      size: 48,
                                      color: whiteColor,
                                    ):const Icon(
                                      Icons.play_arrow,
                                      size: 54,
                                      color: whiteColor,
                                    )
                                ),
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.playSongs(data[controller.playIndex.value].uri, controller.playIndex.value+1);
                            },
                            icon: Icon(
                              Icons.skip_next,
                              size: 40,
                              color: bgDarkColor,
                            )),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
