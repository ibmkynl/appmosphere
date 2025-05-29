import 'package:appmosphere/features/city_search/domain/entitiy/city_model.dart';
import 'package:appmosphere/features/forecast/ui/widget/forecast_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/app_error.dart';
import '../../../current_weather/ui/providers/current_weather_provider.dart';
import '../../../current_weather/ui/widgets/current_weather_widget.dart';
import '../../../forecast/ui/providers/forecast_weather_provider.dart';

class CityWeatherPage extends StatefulWidget {
  final CityModel cityModel;

  const CityWeatherPage({super.key, required this.cityModel});

  static Route<dynamic> route(CityModel cityModel) {
    return MaterialPageRoute(builder: (_) => CityWeatherPage(cityModel: cityModel));
  }

  @override
  State<CityWeatherPage> createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    try {
      await Provider.of<CurrentWeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherByCity(widget.cityModel.name, fresh: false);

      await Provider.of<ForecastWeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherByCity(widget.cityModel.lat, widget.cityModel.lon);
    } on AppError catch (error) {
      debugPrint('Failed to fetch location: ${error.message}');
      ErrorNotification.show(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cityModel.name), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RefreshIndicator(
          onRefresh: () => _refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                CurrentWeatherWidget(city: widget.cityModel),
                SizedBox(height: 30.h),
                ForecastListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
