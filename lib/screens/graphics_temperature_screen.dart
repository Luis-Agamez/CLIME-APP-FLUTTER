import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
import '../blocs/clime/clime_bloc.dart';
import '../constant/constant.dart';

class GraphicsTemperatureScreen extends StatelessWidget {
  const GraphicsTemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimeBloc, ClimeState>(
      builder: (context, state) {
        return SafeArea(
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
                        horizontal: 10, vertical: 15),
                    height: 70,
                    decoration: DecorateionBox.boxDecoration,
                    child: const Text(
                      'Comparacion de Temperaura y Sensacion Termica los Proximos 5 dias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    height: 450,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: Chart(
                      data: state.graphicPoligon,
                      variables: {
                        'index': Variable(
                          accessor: (Map map) => map['index'].toString(),
                        ),
                        'type': Variable(
                          accessor: (Map map) => map['type'] as String,
                        ),
                        'value': Variable(
                          accessor: (Map map) => map['value'] as num,
                        ),
                      },
                      elements: [
                        LineElement(
                          position: Varset('index') *
                              Varset('value') /
                              Varset('type'),
                          shape: ShapeAttr(value: BasicLineShape(loop: true)),
                          color: ColorAttr(
                              variable: 'type', values: Defaults.colors20),
                        )
                      ],
                      coord: PolarCoord(),
                      axes: [
                        Defaults.circularAxis,
                        Defaults.radialAxis,
                      ],
                      selections: {
                        'touchMove': PointSelection(
                          on: {
                            GestureType.scaleUpdate,
                            GestureType.tapDown,
                            GestureType.longPressMoveUpdate
                          },
                          dim: Dim.x,
                          variable: 'index',
                        )
                      },
                      tooltip: TooltipGuide(
                        anchor: (_) => Offset.zero,
                        align: Alignment.bottomRight,
                        multiTuples: true,
                        variables: ['type', 'value'],
                      ),
                      crosshair: CrosshairGuide(followPointer: [false, true]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(62, 66, 107, 0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                        'Valores de Temperatura de los Proximos 5 dias',
                        style: ConstantTextStyle.subTitle),
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
                      data: state.temperatureData,
                      variables: {
                        'Fecha': Variable(
                          accessor: (Map map) => map['Date'] as String,
                          scale: OrdinalScale(tickCount: 0, inflate: true),
                        ),
                        'Temperatura': Variable(
                          accessor: (Map map) =>
                              (map['Temperature'] ?? double.nan) as num,
                        ),
                      },
                      elements: [
                        AreaElement(
                          shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
                          color: ColorAttr(
                              value: Defaults.colors20.first.withAlpha(80)),
                        ),
                        LineElement(
                          shape: ShapeAttr(value: BasicLineShape(smooth: true)),
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
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(62, 66, 107, 0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      'Temperatura de los Proximos 5 dias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      height: 450,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      child: BlocBuilder<ClimeBloc, ClimeState>(
                        builder: (context, state) {
                          return state.graphic.isNotEmpty
                              ? Chart(
                                  data: state.graphic,
                                  variables: {
                                    'day': Variable(
                                      accessor: (Map datum) =>
                                          datum['day'] as String,
                                      scale: OrdinalScale(inflate: true),
                                    ),
                                    'value': Variable(
                                      accessor: (Map datum) =>
                                          datum['value'] as num,
                                      scale: LinearScale(
                                        max: 40,
                                        min: 18,
                                        tickCount: 10,
                                        formatter: (v) => '$v.℃',
                                      ),
                                    ),
                                    'group': Variable(
                                      accessor: (Map datum) =>
                                          datum['group'] as String,
                                    ),
                                  },
                                  elements: [
                                    LineElement(
                                      position: Varset('day') *
                                          Varset('value') /
                                          Varset('group'),
                                      color: ColorAttr(
                                        variable: 'group',
                                        values: [
                                          const Color(0xff5470c6),
                                          const Color.fromARGB(255, 194, 6, 15),
                                          const Color.fromARGB(
                                              255, 13, 161, 33),
                                          const Color.fromARGB(
                                              255, 2, 253, 249),
                                          const Color.fromARGB(
                                              255, 233, 107, 5),
                                          const Color(0xffff99c3),
                                          const Color(0xff5470c6),
                                          const Color(0xff91cc75),
                                          const Color(0xff6dc8ec),
                                          const Color(0xff1e9493),
                                        ],
                                      ),
                                    ),
                                  ],
                                  axes: [
                                    Defaults.horizontalAxis,
                                    Defaults.verticalAxis,
                                  ],
                                  selections: {
                                    'tooltipMouse': PointSelection(on: {
                                      GestureType.hover,
                                    }, devices: {
                                      PointerDeviceKind.mouse
                                    }, variable: 'day', dim: Dim.x),
                                    'tooltipTouch': PointSelection(on: {
                                      GestureType.scaleUpdate,
                                      GestureType.tapDown,
                                      GestureType.longPressMoveUpdate
                                    }, devices: {
                                      PointerDeviceKind.touch
                                    }, variable: 'day', dim: Dim.x),
                                  },
                                  tooltip: TooltipGuide(
                                    followPointer: [true, true],
                                    align: Alignment.topLeft,
                                    variables: ['group', 'value'],
                                  ),
                                  crosshair: CrosshairGuide(
                                    followPointer: [false, true],
                                  ),
                                  annotations: [],
                                )
                              : Container();
                        },
                      )),
                  const SizedBox(height: 50),
                ],
              )
            ]),
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
                'Temperatura',
                style: ConstantTextStyle.textMediumNormal,
              )
            : Container();
      },
    );
  }
}
