import UIKit
import SnapKit

class FirstFacadeCell: UICollectionViewCell {
    
    //MARK: - weatherResDublicate
    var weatherResDublicate: WeatherResponse? {
        didSet {
            setupWeatherInfo()
        }
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blueBg
    }
    
    //MARK: - setupWeatherInfo
    private func setupWeatherInfo() {
        guard let weather = weatherResDublicate else { return }
        let dateSunerise = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
        let dateSunset = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
        let dateDay = Date(timeIntervalSince1970: TimeInterval(weather.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let dateFormatterForDay = DateFormatter()
        dateFormatterForDay.dateFormat = "dd.MM.yyyy HH:mm"
        
        let container = FacadeBlueCont(temp: weather.main.temp,
                                       minTemp: weather.main.temp_min,
                                       maxTemp: weather.main.temp_max,
                                       sunrise: dateFormatter.string(from: dateSunerise),
                                       sunset: dateFormatter.string(from: dateSunset),
                                       cloudy: weather.clouds.all,
                                       wind: weather.wind.speed,
                                       humidity: weather.main.humidity,
                                       date: dateFormatterForDay.string(from: dateDay),
                                       description: String(weather.weather.first?.description ?? "Norm vse"))
        contentView.addSubview(container)
        container.snp.makeConstraints{
            $0.size.equalToSuperview()
        }
    }

    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
