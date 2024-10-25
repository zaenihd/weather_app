import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_bloc/data/my_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory wf =
            WeatherFactory(apiKey, language: Language.INDONESIAN);
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
            print('object $weather');
        emit(WeatherSuccess(weather: weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
