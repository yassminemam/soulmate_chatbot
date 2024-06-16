import 'package:get_it/get_it.dart';
import 'feature/presentation/provider/user/user_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Presentation
   */
  //provider
  sl.registerLazySingleton(() => UserChangeNotifier());
}
