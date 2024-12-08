struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let dt: Int
    
    struct Weather: Codable {
        let main: String
        let description: String
    }
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let humidity: Double
    }
    struct Wind: Codable {
        let speed: Double
    }
    struct Clouds: Codable {
        let all: Int
    }
    struct Sys: Codable {
        let sunrise: Int
        let sunset: Int
    }
}
var weatherDataRes: WeatherResponse?


//Model for 24h
struct ForecastResponse: Codable {
    var list: [Forecast]
}

struct Forecast: Codable {
    var dt: Int
    let main: MainForecast
    let weather: [WeatherCondition]
    var dt_txt: String
    let clouds: CloudsForecast
    let wind: WindForecast
}

struct MainForecast: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let feels_like: Double
}

struct WeatherCondition: Codable {
    let description: String
    let icon: String
    let main: String
}

struct WindForecast: Codable {
    let speed: Double
}
struct CloudsForecast: Codable {
    let all: Int
}
var weatherThreeDayRes: ForecastResponse?
var weatherFiveDayRes: [Forecast]?
