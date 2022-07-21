import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
import '../blocs/clime/clime_bloc.dart';
import '../constant/constant.dart';

class GraphicsHumidityScreen extends StatelessWidget {
  const GraphicsHumidityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        return Container(
          // color: const Color(0xff30BAD6),
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topRight,
          //         end: Alignment.bottomLeft,
          //         colors: [Colors.blue, Colors.blueGrey])),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    const MainContent(),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.graphic_eq_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 60,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(62, 66, 107, 0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'Escala de Humedad los Proximos 5 dias',
                        style: ConstantTextStyle.subTitleBig,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      child: Chart(
                        data: state.humidityData,
                        variables: {
                          'Fecha': Variable(
                            accessor: (Map map) => map['Date'] as String,
                            scale: OrdinalScale(tickCount: 0, inflate: true),
                          ),
                          'Humedad': Variable(
                            accessor: (Map map) =>
                                (map['Humidity'] ?? double.nan) as num,
                          ),
                        },
                        elements: [
                          AreaElement(
                            shape:
                                ShapeAttr(value: BasicAreaShape(smooth: true)),
                            color: ColorAttr(
                                value: Defaults.colors20.first.withAlpha(80)),
                          ),
                          LineElement(
                            shape:
                                ShapeAttr(value: BasicLineShape(smooth: true)),
                            size: SizeAttr(value: 0.5),
                          ),
                        ],
                        axes: [
                          Defaults.horizontalAxis,
                          Defaults.verticalAxis,
                        ],
                        selections: {
                          'touchMove': PointSelection(
                            on: {
                              GestureType.scaleUpdate,
                              GestureType.tapDown,
                              GestureType.longPressMoveUpdate
                            },
                            dim: Dim.x,
                          )
                        },
                        tooltip: TooltipGuide(
                          followPointer: [false, true],
                          align: Alignment.topLeft,
                          offset: const Offset(-20, -20),
                        ),
                        crosshair: CrosshairGuide(followPointer: [false, true]),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        );
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
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        return state.clime.isNotEmpty
            ? const Text(
                'Humedad',
                style: ConstantTextStyle.textMediumNormal,
              )
            : Container();
      },
    );
  }
}
