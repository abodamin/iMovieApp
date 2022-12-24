import 'package:get_it/get_it.dart';
import 'package:i_movie_app/inject/dependency_injection.config.dart';
import 'package:injectable/injectable.dart';



final getIt = GetIt.I;

@InjectableInit()
void initializeGetIt() {
  $initGetIt(getIt);
}

