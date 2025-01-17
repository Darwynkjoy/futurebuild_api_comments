import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:futurebuilder_api_comments/data_model.dart';
import 'package:http/http.dart'as http;

class CommentsPage extends StatefulWidget{
  @override
  State<CommentsPage> createState()=> _commentpageState();
}
class _commentpageState extends State<CommentsPage>{

  late Future<Commentsmodelapi> futureData;
  
  @override
  void initState(){
    super.initState();
    futureData= _getdata();
  }

  Future<Commentsmodelapi?> _getdata()async{
    try{ String url="https://dummyjson.com/comments";
    http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return Commentsmodelapi.fromJson(json.decode(res.body));
      }}
      catch(e){
        debugPrint(e.toString());
      }
    return null;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("COMMENTS",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(future: futureData, builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError){
          throw Exception("failed to load data");        
          }
          else if(snapshot.hasData&&snapshot.data != null){
            final Commentdata=snapshot.data!.comments;
            return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 2
          ),
          itemCount: Commentdata.length,
        itemBuilder: (context,index){
          final data=Commentdata[index];
          return Container(
            decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.red),borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("@${data.user.username} ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                      CircleAvatar(radius: 4,backgroundColor: const Color.fromARGB(255, 90, 90, 90),),
                      Text(" ${data.user.fullName}",style: TextStyle(fontSize: 20,color: Colors.black),),
                    ],
                  ),
                  Text("${data.body}",style: TextStyle(fontSize: 23,color: Colors.black),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.thumb_up_alt,color: Colors.red,size: 25,),
                          Text("${data.postId}",style: TextStyle(fontSize: 20,color: Colors.black),),
                        ],
                      ),
                      SizedBox(width: 15,),
                      Column(
                        children: [
                          Icon(Icons.thumb_down_alt,color: Colors.red,size: 25,),
                          Text("${data.user.id}",style: TextStyle(fontSize: 20,color: Colors.black),),
                        ],
                      ),
                    ],
                  ),
                  Text("${data.likes} replies",style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 255, 17, 0),fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          );
        }
        ),
      );
          }
          else{
            return Text("there is not data available");
          }
      })
    );
  }
}