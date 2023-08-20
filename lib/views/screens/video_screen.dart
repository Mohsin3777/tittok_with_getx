import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/controllers/videocontroller.dart';
import 'package:tiktok_clone/views/screens/comment_screen.dart';

import '../widgets/circle_animation.dart';
import '../widgets/videoplayer_item.dart';

class VideoScreen extends StatelessWidget {
 

 final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto){
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                         borderRadius: BorderRadius.circular(25),  
                child: Image(image: NetworkImage(profilePhoto),fit: BoxFit.cover,)),
            ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(

      body: Obx(
        (){
          return PageView.builder(
        itemCount: videoController.videoList.length,
        controller: PageController(initialPage: 0,viewportFraction: 1),
        scrollDirection: Axis.vertical,

        itemBuilder: (context,index){
          final data =videoController.videoList[index];
return Stack(
  children: [

    
    
    VideoPlayerItem(videoUrl:data.videoUrl,),
         Column(
        children: [
      const    SizedBox(height: 100,),
   
          Expanded(child: Container(padding:const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
              
                    Text(data.userName,style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
              
                        Text(data.caption,style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
              
                    Icon(Icons.music_note,size: 15,color: Colors.white,),
                         Text(data.caption,style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),

              Container(
                width: 100,
                margin: EdgeInsets.only(top: size.height/5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
buildProfile(data.profilePhoto),
Column(
  children: [
    InkWell(
      onTap: ()=> videoController.likeVideo(data.id),
      child: Icon(Icons.favorite,size: 30,
      color:data.likes.contains(authController.user.uid) ?  Colors.red:Colors.white,),),
    const  SizedBox(height: 7,),
      Text(data.likes.length.toString(),style: TextStyle(fontSize: 15,color: Colors.white,),)
      
  ],
),
Column(
  children: [
    InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentScreen(id: data.id,))),
      child: Icon(Icons.comment,size: 30,color: Colors.white,),),
      SizedBox(height: 7,),
      Text(data.commentCount.toString(),style: TextStyle(fontSize: 15,color: Colors.white,),)
      
  ],
),
Column(
  children: [
    InkWell(
      onTap: (){},
      child: Icon(Icons.reply,size: 30,color: Colors.white,),),
      SizedBox(height: 7,),
      Text(data.shareCount.toString(),style: TextStyle(fontSize: 15,color: Colors.white,),)
      
  ],
),

CircleAnimation(child: buildMusicAlbum(data.profilePhoto),),
                ]),
              ),
            ],
          ),
          ),),
          
        ],
      )
  ],
);

      });
        }
      )
    );
  }
}

buildMusicAlbum(String  profilePhoto){
  return SizedBox(
    width: 60,
    height: 60,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colors.grey,
              Colors.white
            ]),
            borderRadius: BorderRadius.circular(25)
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(image: NetworkImage(profilePhoto),fit: BoxFit.cover,),
          ),
        )
      ],
    ),
  );
}