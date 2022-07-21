import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/clime/clime_bloc.dart';
import '../constant/constant.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Column(
          children: const [
            MainContent(),
            SizedBox(height: 10),
            Icon(
              Icons.timer_outlined,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(height: 30),
            ListDay(),
          ],
        )
      ]),
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
        return state.clime.isNotEmpty ? ConstantText.textProx24h : Container();
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
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 80,
                          decoration: DecorateionBox.boxDecoration,
                          margin: const EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${state.climePredictions[0].list[index].dtTxt}'
                                      .replaceRange(0, 10, '')
                                      .replaceRange(5, 12, ''),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${state.climePredictions[0].list[index].main.temp}ºC',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  'assets/${state.climePredictions[0].list[index].weather[0].icon}.png',
                                  scale: 2.5,
                                ),
                              ]),
                        )
                      ]),
                    )))
            : Container();
      },
    );
  }
}
