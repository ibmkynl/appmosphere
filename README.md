# Weather Forecast App

A Flutter application to view **current weather** and **5-day forecast** data for any city using **OpenWeatherMap** APIs.

## 🌤️ Overview

This app uses the **free OpenWeather APIs** for:
- **Current City Weather**
- **5-Day Forecast**

These were the only free APIs available and utilized for fetching real-time weather data.

> **Note:**  
> Instead of requesting device **location permissions**, the app uses **IP-based location detection** to automatically find the user's city. This improves privacy and avoids permission prompts.

## 🔒 API Key Security

- The OpenWeather API Key is **hidden securely** using a **`.env`** file.
- The app reads API keys via **flutter_dotenv** to avoid exposing sensitive information.

## 🛠 Architecture

The project strictly follows **Clear and Layered Architecture** principles:
- **Presentation Layer**: UI components, state management using **Provider**.
- **Domain Layer**: Business logic encapsulated in **Use Cases**.
- **Data Layer**: API integration and **Hive** for local data caching.
- **Dependency Injection**: Managed via **get_it** for better scalability and decoupling.

## 📱 App Features

- **Home Page**:
  - Displays the current weather of the automatically detected city.
  - Shows a 5-day forecast summary.

- **Search Page**:
  - Search for any city’s weather.
  - Searched cities are saved **locally** to **minimize API usage**.

- **Detail Pages**:
  - Tap on a forecast day to view **detailed weather information** (humidity, pressure, wind speed, etc.).

- **Settings Page**:
  - **Theme Change**: Light and Dark mode toggle.
  - **Unit Change**: Switch between **Celsius** and **Fahrenheit**.
  - **Language Change**: Multi-language support (English, Spanish, Turkish, etc.).

## 💾 Local Storage Optimization

- **Searched City Information**: Stored locally after first search to avoid repeated API calls.
- **City Weather Data**: Cached using **Hive** to deliver faster results and **reduce network traffic**.

## 🔌 API Endpoints Used

- **Current Weather API**:  
  `https://api.openweathermap.org/data/2.5/weather`
- **5-Day Forecast API**:  
  `https://api.openweathermap.org/data/2.5/forecast`

*(You need to configure your own OpenWeatherMap API key inside a `.env` file.)*

## ✨ Other Highlights

- **Clean Code** practices following SOLID principles.
- **Error Handling** with user-friendly messages for network failures and invalid searches.
- **Theme and Localization** fully supported across the app.
- **Responsive Design** using **ScreenUtil** (Base size: 440×956).

