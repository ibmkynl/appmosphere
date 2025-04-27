import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../core/injection/service_locator.dart'; // Import GetIt
import '../../../feature_widgets/error_widget.dart';
import '../provider/city_search_provider.dart';
import 'city_weather_page.dart';

class CitySearchPage extends StatelessWidget {
  const CitySearchPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder:
          (_) => ChangeNotifierProvider<CitySearchProvider>(
            create: (_) => sl<CitySearchProvider>(),
            child: const CitySearchPage(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CitySearchProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search City')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: provider.onQueryChanged,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    provider.onQueryChanged('');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Center(child: LinearProgressIndicator())
            else if (provider.error != null)
              CustomErrorWidget(message: provider.error!.i18n())
            else if (provider.cities.isEmpty)
              Text('no_cities_found'.i18n())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.cities.length,
                  itemBuilder: (context, index) {
                    final city = provider.cities[index];
                    return ListTile(
                      title: Text('${city.name}, ${city.country}'),
                      subtitle: Text('${"latitude".i18n()}: ${city.lat}, ${"longitude".i18n()}: ${city.lon}'),
                      onTap: () => Navigator.push(context, CityWeatherPage.route(city)),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
