import 'package:breaking_bad/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel model;

  const CharacterDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: CustomScrollView(
        physics:const BouncingScrollPhysics() ,
        slivers: [
          sliverAppBarBuilder(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start
                    ,
                    children: [
                      characterInfo('Name : ', model.name),
                      myDivider(),
                      characterInfo('Job : ',model.occupation.join(' / ')),
                      myDivider(),
                      characterInfo('Seasons : ',model.appearance.join(' / ').toString() ),
                      myDivider(),
                      characterInfo('Status : ',model.status),
                      myDivider(),
                      characterInfo('Actor : ',model.portrayed ),
                      myDivider(),

                    ],
                  ),
                ),
                const SizedBox(height: 300,)
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget myDivider()=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.white,
    ),
  );

  Widget characterInfo(String title, String value) => RichText(
    maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            TextSpan(
                text: value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    //fontWeight: FontWeight.bold
                )
            )
        ],
      ));

  Widget sliverAppBarBuilder() => SliverAppBar(
        expandedHeight: 700,
        backgroundColor: Colors.grey[700],
        pinned: true,
        stretch: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            model.nickname,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          background: Hero(
              tag: model.charId,
              child: Image.network(
                model.img,
                fit: BoxFit.cover,
              )),
        ),
      );
}
