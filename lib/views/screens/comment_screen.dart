// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'package:tiktok_clone/controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final String id;
 CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

final TextEditingController _commentController = TextEditingController();
CommentController  commentController =Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(
           
               () {
                    return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.black,
                      
                      backgroundImage: NetworkImage('profile'),
                      ),
                      title: Row(
                        children: [
                          Text('username',
                          style:  const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                                 Text('username',
                          style:  const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          )
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text('date',
                          style:  const TextStyle(fontSize: 12,color: Colors.white),
                
                          ),
                          const SizedBox(width: 10,),
                             Text('10 likes',
                          style:  const TextStyle(fontSize: 12,color: Colors.white),
                
                          ),
                
                        ],
                
                        
                      ),
                      trailing: InkWell(
                        onTap: (){},
                        child: Icon(Icons.favorite,size: 25,color: Colors.red,)),
                    );
                              });
                  }
                ),),
             const Divider(),

             ListTile(
              title: TextField(
                controller: _commentController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                          fontSize: 20,
                  color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,),),
               focusedBorder   : UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,),),
                ),
                
              ),

              trailing: TextButton(onPressed: ()=>commentController.postComment(_commentController.text), child: Text('Send',style: TextStyle(fontSize: 16,color: Colors.white),)),
             ),

            ],
          ),
        ),
      ),
    );
  }
}
