import 'package:clima_app/blocs/location/location_bloc.dart';
import 'package:clima_app/screens/principal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../blocs/clime/clime_bloc.dart';
import '../constant/constant.dart';
import 'details_screen.dart';
import 'graphic_clouds_screen.dart';
import 'graphics_humidity_screen.dart';
import 'graphics_temperature_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ClimeBloc climeBloc;
  late LocationBloc locationBloc;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        climeBloc = BlocProvider.of<ClimeBloc>(context);
        climeBloc.getClime(state.ltd, state.lgd);
        climeBloc.getClimePredictions(state.ltd, state.lgd);
        return state.getPosition
            ? BlocBuilder<ClimeBloc, ClimeState>(builder: (context, state) {
                return Container(
                    decoration: BoxDecoration(
                        gradient: state.rain
                            ? ColorsGradient.gradientRain
                            : ColorsGradient.gradientSun),
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: const <Widget>[
                        Page1(),
                        SingleChildScrollView(child: Page2()),
                        SingleChildScrollView(
                          child: GraphicsTemperatureScreen(),
                        ),
                        GraphicsHumidityScreen(),
                        GraphicsCloudsScreen(),
                        // EchartsPage()
                      ],
                    ));
              })
            : Center(child: Lottie.asset('assets/satelite.json'));
      },
    ));
  }
}
