import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bloc/charac_episode/charac_episode_bloc.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/ui/screens/detailscharacter/widget/animated_displacement.dart';
import 'package:rickandmorty/ui/screens/detailscharacter/widget/text_span_data.dart';
import 'package:rickandmorty/ui/screens/episodes/episodes_screen.dart';
import 'package:rickandmorty/ui/widgets/bottom_pop.dart';
import 'package:rickandmorty/ui/widgets/loading_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);
  final Character character;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  CharacterEpisodeBloc _characterEpisodeBloc = CharacterEpisodeBloc();
  @override
  void initState() {
    _characterEpisodeBloc = context.read<CharacterEpisodeBloc>();
    _characterEpisodeBloc
        .add(GetCharacterEpisodeEvent(character: widget.character));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topCardHeight = size.height / 2;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: topCardHeight,
              child: AnimatedDisplacement(
                character: widget.character,
              ),
            ),
            const Positioned(
              left: 10,
              top: 10,
              child: BottomPop(),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              width: size.width,
              height: size.height / 2.2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                color: widget.character.status == 'Dead'
                                    ? Colors.red
                                    : widget.character.status == 'Alive'
                                        ? Colors.green
                                        : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.character.status!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                widget.character.gender == 'Male'
                                    ? const Icon(Icons.male,
                                        size: 25, color: Colors.blue)
                                    : widget.character.gender == 'Female'
                                        ? const Icon(
                                            Icons.female,
                                            size: 25,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.public,
                                            size: 25,
                                            color: Colors.green,
                                          ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.character.gender!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.fingerprint,
                                    size: 25, color: Colors.green[700]),
                                const SizedBox(width: 10),
                                Text(
                                  widget.character.species!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Card(
                                color: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextSpanData(
                                          title: 'Type: ',
                                          text: widget.character.type == ''
                                              ? 'Not found'
                                              : widget.character.type!),
                                      TextSpanData(
                                          title: 'Episodes: ',
                                          text:
                                              '${widget.character.episode!.length}'),
                                      TextSpanData(
                                        title: 'Origin: ',
                                        text: widget.character.origin!.name!,
                                      ),
                                      TextSpanData(
                                        title: 'Location: ',
                                        text: widget.character.location!.name!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Episodes:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<CharacterEpisodeBloc,
                          CharacterEpisodeState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case CharacterEpisodeStatus.loading:
                              return const LoadingWidget();
                            case CharacterEpisodeStatus.success:
                              if (state.posts.isEmpty) {
                                return const Center(
                                  child: Text("No Characters"),
                                );
                              }
                              return ListView.builder(
                                itemCount: state.posts.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return index >= state.posts.length
                                      ? const LoadingWidget()
                                      : EpisodeItem(
                                          episode: state.posts[index]);
                                },
                              );
                            case CharacterEpisodeStatus.error:
                              return Center(child: Text(state.errorMessage));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
