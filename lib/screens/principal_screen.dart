import 'package:clima_app/screens/data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/clime/clime_bloc.dart';
import '../constant/constant.dart';

class Page1 extends StatelessWidget {
  const Page1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [const Body(), DataScreen()],
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: const [Background(), MainContent()],
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(child: BackgroundImage());
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        if (state.clime.isNotEmpty) {
          switch (state.clime[0].weather[0].description) {
            // case 'overcast clouds':
            //   return Image.asset(
            //     'assets/foggy.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'Clouds':
            //   return Image.asset(
            //     'assets/clouds.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'clear sky':
            //   return Image.asset(
            //     'assets/clear_sky.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'few clouds':
            //   return Image.asset(
            //     'assets/few_clouds.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'heavy intensity rain':
            //   return Image.asset(
            //     'assets/rain.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'thunderstorm':
            //   return Image.asset(
            //     'assets/thunderstorm.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'snow':
            //   return Image.asset(
            //     'assets/snow.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'mist':
            //   return Image.asset(
            //     'assets/mist.jpg',
            //     fit: BoxFit.cover,
            //   );

            // case 'light intensity drizzle':
            //   return Image.asset(
            //     'assets/drizzle.jpg',
            //     fit: BoxFit.cover,
            //   );
            // case 'light rain':
            //   return Image.asset(
            //     'assets/drizzle.jpg',
            //     fit: BoxFit.cover,
            //   );

            default:
              return Container();
          }
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }
      },
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);

    return const SafeArea(
      bottom: false,
      child: InitialData(textStyle: textStyle),
    );
  }
}

class InitialData extends StatelessWidget {
  const InitialData({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        return Stack(
            children: state.clime
                .map((e) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/${e.weather[0].icon}.png',
                                scale: 0.7,
                              ),
                              Text(e.name, style: ConstantTextStyle.textCity),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sensacion Termica : ',
                                style: ConstantTextStyle.textMediumLight),
                            TweenAnimationBuilder<double>(
                              curve: Curves.easeInOut,
                              tween: Tween(begin: 0, end: e.main.feelsLike),
                              duration: const Duration(milliseconds: 4200),
                              builder: ((context, value, child) {
                                return Text(value.toStringAsPrecision(3),
                                    style: ConstantTextStyle.textMediumLight);
                              }),
                            ),
                            const Text('ºC',
                                style: ConstantTextStyle.textMediumLight)
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text('Humedad: ${e.main.humidity}%',
                            style: ConstantTextStyle.textMediumBold),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TweenAnimationBuilder<int>(
                              curve: Curves.easeInOut,
                              tween:
                                  IntTween(begin: 0, end: e.main.temp.toInt()),
                              duration: const Duration(milliseconds: 4000),
                              builder: ((context, value, child) {
                                return Text(value.toString(),
                                    style: ConstantTextStyle.textBig);
                              }),
                            ),
                            const Text('ºC', style: ConstantTextStyle.textBig)
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text('Viento ${e.wind.speed} m/s',
                            style: ConstantTextStyle.textMediumBold),
                        const SizedBox(height: 20),
                        Text('Presion : ${e.main.pressure}ºhPa',
                            style: ConstantTextStyle.textMediumLight),
                        Expanded(child: Container()),
                        const Icon(Icons.keyboard_arrow_down,
                            size: 100, color: Colors.white)
                      ],
                    ))
                .toList());
      },
    );
  }
}
