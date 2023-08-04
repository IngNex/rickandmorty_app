import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bloc/episodes/episodes_bloc.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';
import 'package:rickandmorty/ui/widgets/animation_translate.dart';
import 'package:rickandmorty/ui/widgets/app_bar_image.dart';
import 'package:rickandmorty/ui/widgets/loading_widget.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll)) {
      context.read<EpisodesBloc>().add(GetEpisodesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AnimationTranslate(
            top: false,
            child: AppBarImage(),
          ),
          Expanded(
            child: AnimationTranslate(
              child: BlocBuilder<EpisodesBloc, EpisodesState>(
                builder: (context, state) {
                  switch (state.status) {
                    case EpisodesStatus.loading:
                      return const LoadingWidget();
                    case EpisodesStatus.success:
                      if (state.posts.isEmpty) {
                        return const Center(
                          child: Text("No Episodes"),
                        );
                      }
                      return GridView.builder(
                        itemCount: state.hasReachedMax
                            ? state.posts.length
                            : state.posts.length + 1,
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8.0),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 4.8,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.posts.length
                              ? const LoadingWidget()
                              : EpisodeItem(episode: state.posts[index]);
                        },
                      );

                    case EpisodesStatus.error:
                      return Center(child: Text(state.errorMessage));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeItem extends StatelessWidget {
  const EpisodeItem({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(child: Text(episode.id.toString())),
        title: Text(episode.name!),
        subtitle: Text(episode.airDate!),
        trailing: Text(episode.episode!),
      ),
    );
  }
}
