import 'package:breaking_bad/cubit/cubit.dart';
import 'package:breaking_bad/cubit/states.dart';
import 'package:breaking_bad/models/character_model.dart';
import 'package:breaking_bad/screens/character_details_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit=AppCubit.get(context);
          List<CharacterModel> models =cubit .modelsList;
        //  List<CharacterModel> searchingList =cubit.searchingList;


          return Scaffold(
            backgroundColor: Colors.grey[700],
            appBar:AppBar(
              elevation: 0,
              actions:[
                IconButton(onPressed: (){cubit.search();}, icon:cubit.defaultIcon )
              ] ,
              titleSpacing: cubit.titleSpacing,
              // centerTitle: true,
              backgroundColor: Colors.grey[700],
              toolbarHeight: 70,
              title:cubit.defaultTitleAppBar
            ),
            body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return ConditionalBuilder(
                        condition: state is! AppGetCharactersDataLoadingState,
                        builder: (context) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1 / 1.6),
                                itemBuilder: (context, index) =>
                                    itemBuilder(cubit.searchController.text!=''? cubit.searchingList[index]: models[index], context),
                                itemCount:cubit.searchController.text!=''? cubit.searchingList.length: models.length,
                              ),
                            ),
                        fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )));
                  } else {
                    return offlineWidgetBuilder();
                  }
                },
                child: Container()),
          );
        });
  }

  Widget itemBuilder(CharacterModel model, BuildContext context) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.black),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CharacterDetailsScreen(model: model)));
        },
        child: Hero(
          tag: model.charId,
          child: GridTile(
            footer: Container(
              height: 30,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Colors.black54),
              margin: const EdgeInsetsDirectional.only(end: 1.5, start: 1.5),
              alignment: Alignment.bottomCenter,
              child: Center(
                child: Text(
                  model.name,
                  style: const TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(
                      model.img,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ));

  Widget offlineWidgetBuilder() => SizedBox(
        width: double.infinity,
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/no-wifi.png',
              height: 250,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'You are not connected,',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Please check your internet',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
