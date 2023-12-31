import 'package:flash_chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'Customshape.dart';

class Globlimg extends StatefulWidget {
  static String id = 'global_screen';

  const Globlimg({Key key}) : super(key: key);

  @override
  State<Globlimg> createState() => _GloblimgState();
}

class _GloblimgState extends State<Globlimg> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  void initState(){
    super.initState();
    controller=AnimationController(vsync: this,
        duration: Duration(seconds: 1),
        upperBound: 1.0);
    animation= CurvedAnimation(parent: controller, curve: Curves.easeOutCirc);
    controller.forward();
    controller.addListener(() {
      setState((){});
      print(controller.value);
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: PopupMenuButton(itemBuilder: (context){
              return[
                PopupMenuItem(child: TextButton(
                  child: Text('Leave Chat'),
                  onPressed: (){
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ))
              ];
            }),
          )
        ],
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        toolbarHeight: 150,
        centerTitle: true,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey,
            child: Center(child: Text('GLOBAL CHAT', style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20,))),
          ),
        ),
      ),
        drawer: Drawer(
          child:Column(
            children: [
              ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
              ListTile(
                title: Text('Help and FeedBack'),
                leading: Icon(Icons.help_center),
              ),
            ],
          )

        ),
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          // color: Colors.grey[800],
          // image: DecorationImage(opacity: 0.6,
          //   // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
          //   image:NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvzXZQtqwr-avnb_IACT9F4rUTms_rDDjOdg&usqp=CAU"),
          //   fit: BoxFit.cover
          // )
        ),
        child: Stack(
          children: [

            Positioned(

              left: 430,
              child: Container(
                height: animation.value * 100,
                child:
                Image.asset('images/logo.png',
                height: 250,),
              ),
            ),


            Positioned(
              top: 100,
              left: 300,
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(

                    TextSpan(
                      children: [

                        TextSpan(text: "Terms and Conditions:\n", style: TextStyle(fontSize: 30, color:Colors.black,fontWeight:FontWeight.bold)),

                        TextSpan(text: "\u2022 You are at least 18 years of age.\n", style: TextStyle(fontSize: 15, color:Colors.black,fontWeight:FontWeight.bold)),
                        TextSpan(text: "\u2022 You will not use the Service to engage in any illegal activity.\n",style: TextStyle(fontSize: 15, color:Colors.black,fontWeight:FontWeight.bold)),
                        TextSpan(text: "\u2022 You will follow any and all laws, rules, and regulations when using the Services offered by Presence Global.\n", style: TextStyle(fontSize: 15, color:Colors.black,fontWeight:FontWeight.bold)),
                        TextSpan(text: "\u2022 All information that you provide to Presence Global when enrolling in the Services is accurate, complete, and truthful.\n", style: TextStyle(fontSize: 15, color:Colors.black,fontWeight:FontWeight.bold))
                      ]
                    )
                  ),
                ),
              ),
            ),

            Positioned(

              top: 330,
              left: 430,
              child: SizedBox(
                height: 50,
                width: 80,
                child: TextButton(

                    onPressed: (){

                      Navigator.pushNamed(context, ChatScreen.id );
                    },
                    child: Text('Enter Chat', style: TextStyle(fontWeight: FontWeight.bold),),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.all(5),

                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      )
                    )
                  ),

                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
