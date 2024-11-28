import '../../../../domain/entities/actor/actor.dart';
import '../../../../domain/entities/result.dart';
import '../../../../domain/usecases/get_actors/get_actors.dart';
import '../../../../domain/usecases/get_actors/get_actors_param.dart';
import '../../usecase/get_actors_provider/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@Riverpod()
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  var actorsResult = await getActors(GetActorsParam(movieId: movieId));

  return switch (actorsResult) {
    Success(value: final actors) => actors,
    Failed(message: _) => const []
  };
}
