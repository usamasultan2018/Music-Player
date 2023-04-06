
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
class PlayerController extends GetxController{
final  audioQuery  = OnAudioQuery();
final audioPlayer = AudioPlayer();
var playIndex  = 0.obs;
var isPlaying  = false.obs;
var duration = ''.obs;
var position = ''.obs;
var max = 0.0.obs;
var value = 0.0.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermission();
  }
  checkDurationToSec(seconds){
  var duration = Duration(seconds:seconds);
  audioPlayer.seek(duration);
  }
  updatePosition(){
  audioPlayer.durationStream.listen((event) {
    duration.value = event.toString().split(".")[0];
    max = event!.inSeconds.toDouble() as RxDouble;
  });
  audioPlayer.durationStream.listen((event) {
    duration.value = event.toString().split(".")[0];
    value = event!.inSeconds.toDouble() as RxDouble;
  });
  }
  checkPermission()async{
    var perm = await Permission.storage.request();
    if(perm.isGranted){

    }
    else{
      checkPermission();
    }

  }
  playSongs(String? url,int index) {
    playIndex.value =index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(url!)),
      );
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    }
   on Exception catch (e) {
        print(e.toString());
    }
  }
}