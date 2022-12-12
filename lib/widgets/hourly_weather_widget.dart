import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_phone_program/controller/global_controller.dart';
import 'package:my_phone_program/model/weather_data_hourly.dart';
import 'package:my_phone_program/utilis/custom_color.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const Text(
            "Today",
            style: TextStyle(
              fontSize: 18
            ),
          ),
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20
          ),
        ),
        hourlyList(),
      ],
    );
  }
  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12 ? 14: weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
            onTap: () {
              cardIndex.value = index;
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.5, 0),
                    blurRadius: 30,
                    spreadRadius: 1,
                    color: CustomColors.dividerLine.withAlpha(150)
                  )
                ],
                gradient: cardIndex.value == index ? const LinearGradient(colors: [
                  CustomColors.firstGradientColor,
                  CustomColors.secondGradientColor
                ]) : null),
              child: HourlyDetails(
                index: index,
                cardIndex: cardIndex.toInt(),
                temp: weatherDataHourly.hourly[index].temp!,
                time: weatherDataHourly.hourly[index].dt!,
                weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
              ),
            ),)));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int time;
  int index;
  int cardIndex;
  String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  HourlyDetails({Key? key,
    required this.cardIndex,
    required this.index,
    required this.time,
    required this.temp,
    required this.weatherIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(),
          margin:  const EdgeInsets.only(top: 10),
          child: Text(getTime(time), style: TextStyle(color: cardIndex == index
              ? Colors.white
              : CustomColors.textColorBlack
          )),
        ),
        Container(
          margin:  const EdgeInsets.all(5),
          child: Image.asset("assets/weather/$weatherIcon.png",
          height: 40,
          width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°", style: TextStyle(color: cardIndex == index
              ? Colors.white
              : CustomColors.textColorBlack),),
        )
      ],
    );
  }
}