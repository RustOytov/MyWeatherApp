import UIKit
import Foundation

func fetchWeatherData(nameCity: String, completion: @escaping(WeatherResponse?) -> Void) {
    let apiKey = "API-KEY"
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity)&lang=ru&appid=\(apiKey)&units=metric"
    
    guard let url = URL(string: urlString) else {
        print("url uncorrected")
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("error \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("Error data")
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(WeatherResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion(weather)
            }
        }catch {
            print("Error parsing")
            completion(nil)
        }
    }
    task.resume()
}

func fetchThreeHour(cityName: String, completion: @escaping (ForecastResponse?) -> Void) {
    let apiKey = "API-KEY"
    let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&units=metric"
    
    guard let url = URL(string: urlString) else {
        print("url uncorrected")
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("error data")
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let forecastResponse = try decoder.decode(ForecastResponse.self, from: data)
            
            DispatchQueue.main.async{
                completion(forecastResponse)
            }
        } catch {
            completion(nil)
            print("Erorr parsing")
        }
    }.resume()
}
func processDailyForecasts(from response: ForecastResponse) -> [Forecast] {
    var dailyForecasts: [Forecast] = []
    var processedDates: Set<String> = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Формат для группировки по дням
    
    for forecast in response.list {
        // Преобразуем Unix-время в строку даты
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        let dateString = dateFormatter.string(from: date)
        
        // Добавляем прогноз, если день еще не обработан
        if !processedDates.contains(dateString) {
            dailyForecasts.append(forecast)
            processedDates.insert(dateString)
        }
    }
    
    return dailyForecasts
}

func fetchFiveDays(cityName: String, completion: @escaping ([Forecast]?) -> Void) {
    let apiKey = "API-KEY"
    let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&lang=ru&appid=\(apiKey)&units=metric"
    
    guard let url = URL(string: urlString) else {
        print("URL uncorrected")
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("Error: No data")
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let forecastResponse = try decoder.decode(ForecastResponse.self, from: data)
            
            // Обрабатываем данные через отдельную функцию
            let dailyForecasts = processDailyForecasts(from: forecastResponse)
            
            DispatchQueue.main.async {
                completion(dailyForecasts)
            }
        } catch {
            completion(nil)
            print("Error parsing JSON")
        }
    }.resume()
}
