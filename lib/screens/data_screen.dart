import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/clime/clime_bloc.dart';
import '../constant/constant.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xff30BAD6),
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomLeft,
      //         colors: [Colors.blue, Colors.blueGrey])),
      child: SafeArea(
        child: Column(children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Column(
            children: const [
              MainContent(),
              Icon(
                Icons.location_pin,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              ListDay(),
            ],
          )
        ]),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        return state.clime.isNotEmpty
            ? Text(
                state.clime[0].name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
            : Container();
      },
    );
  }
}

class ListDay extends StatelessWidget {
  const ListDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        return state.climePredictions.isNotEmpty
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      child: Row(
                        children: state.climePredictions[0].list
                            .map((item) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${item.dtTxt}'
                                              .replaceRange(0, 10, '')
                                              .replaceRange(5, 12, ''),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${item.main.temp}º',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Image.asset(
                                          'assets/${item.weather[0].icon}.png',
                                          scale: 2.5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.air_outlined,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              ' :${item.wind.speed} m/s',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ]),
                                ))
                            .toList(),
                      ),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 110,
                      decoration: DecorateionBox.boxDecoration,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(children: [
                              const Text(
                                'Latitud',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text('${state.clime[0].coord.lat}',
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(height: 5),
                              const Text(' Longitud',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2),
                              Text('${state.clime[0].coord.lon}',
                                  style: const TextStyle(color: Colors.white))
                            ]),
                            Time(
                              time: state.clime[0].sys.sunrise ?? 0,
                              time1: state.clime[0].sys.sunset ?? 0,
                              visibility: state.clime[0].visibility,
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      height: 250,
                      decoration: DecorateionBox.boxDecoration,
                      child: Column(children: [
                        Item(
                          title1: 'Temperatura',
                          title2: 'Sencion Termica',
                          value1: '${state.clime[0].main.temp}ºC',
                          value2: '        ${state.clime[0].main.feelsLike}ºC',
                        ),
                        const SizedBox(height: 12),
                        Item(
                          title1: 'Humedad',
                          title2: 'Presion Atm',
                          value1: '${state.clime[0].main.humidity}%',
                          value2: '${state.clime[0].main.pressure}hPa',
                        ),
                        const SizedBox(height: 12),
                        Item(
                          title1: 'Temperatura Min',
                          title2: 'Temperatura Max',
                          value1: '${state.clime[0].main.tempMax}ºC',
                          value2: '${state.clime[0].main.tempMin}ºC',
                        )
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: DecorateionBox.boxDecoration,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.air_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Velocidad',
                                  style: ConstantTextStyle.textNormal,
                                ),
                                Text(
                                  '${state.clime[0].wind.speed} m/s',
                                  style: ConstantTextStyle.textNormal,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Rafagas ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(
                                  '${state.clime[0].wind.gust} m/s',
                                  style: ConstantTextStyle.textNormal,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Direccion',
                                    style: ConstantTextStyle.textNormal),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.wind_power,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '${state.clime[0].wind.deg}º',
                                      style: ConstantTextStyle.textNormal,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ]),
                    )
                  ],
                ),
              )
            : Container();
      },
    );
  }
}

class Time extends StatelessWidget {
  Time({
    Key? key,
    this.time = 0,
    this.time1 = 0,
    required this.visibility,
  }) : super(key: key);
  final int time;
  final int time1;
  final int visibility;
  @override
  Widget build(BuildContext context) {
    DateTime sunrise = DateTime.utc(0, 0, 0);
    DateTime sunset = DateTime.utc(0, 0, 0);
    if (time > 0) {
      sunrise = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    }
    if (time1 > 0) {
      sunset = DateTime.fromMillisecondsSinceEpoch(time1 * 1000);
    }
    return Column(children: [
      Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              '   Amanecer',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Image.asset(
                  'assets/01d.png',
                  scale: 2.5,
                ),
                Text(
                  '$sunrise'.replaceRange(0, 10, '').replaceRange(5, 12, ''),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ]),
          const SizedBox(
            width: 20,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              '   Puesta de sol',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Image.asset(
                  'assets/01n.png',
                  scale: 2.5,
                ),
                Text(
                  '$sunset'.replaceRange(0, 10, '').replaceRange(5, 12, ''),
                  style: ConstantTextStyle.textNormal,
                ),
              ],
            )
          ]),
        ],
      ),
      Row(children: [
        const Text(
          'Visibilidad',
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Text(
          ':   $visibility metros',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ])
    ]);
  }
}

class Item extends StatelessWidget {
  final String value1;
  final String value2;
  final String title1;
  final String title2;
  const Item({
    Key? key,
    required this.value1,
    required this.value2,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1, style: ConstantTextStyle.subTitle),
            const SizedBox(height: 10),
            Text(
              value1,
              style: ConstantTextStyle.textNormal,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title2, style: ConstantTextStyle.subTitle),
            const SizedBox(height: 10),
            Text(
              value2,
              style: ConstantTextStyle.textNormal,
            ),
          ],
        )
      ],
    );
  }
}
