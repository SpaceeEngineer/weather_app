import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone_program/controller/global_controller.dart';
import 'package:my_phone_program/utilis/custom_color.dart';
import 'package:my_phone_program/widgets/comfort_level.dart';
import 'package:my_phone_program/widgets/daily_data_forecast.dart';
import 'package:my_phone_program/widgets/header_widget.dart';
import 'package:my_phone_program/widgets/hourly_weather_widget.dart';

import '../widgets/current_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/clouds.png",
                        height: 200, width: 200),
                    const CircularProgressIndicator()
                  ],
                ),
              )
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getWeatherData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeather()),
                    const SizedBox(
                      height: 20,
                    ),
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getWeatherData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather()),
                  ],
                ),
              )),
      ),
    );
  }
}
