part of 'episodes_bloc.dart';

abstract class EpisodesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEpisodesEvent extends EpisodesEvent {}
