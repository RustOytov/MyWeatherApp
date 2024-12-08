import UIKit
import SnapKit

class ThirdFacadeCell: UICollectionViewCell {
    
    // MARK: - weatherFDResDublicate

    var weatherFDResDublicate: [Forecast]? {
            didSet {
                if index != nil {
                    setupWeatherInfo()
                }
            }
        }
        
    // MARK: - index
    var index: Int? {
        didSet {
            if weatherFDResDublicate != nil {
                setupWeatherInfo()
            }
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .grayCont
    }
    
    // MARK: - setupWeatherInfo
    private func setupWeatherInfo() {
        guard let weather = weatherFDResDublicate,
              let index = index,
              index >= 0,
              index < weather.count else {
            print("Invalid data or index out of range")
            return
        }
        
        let forecast = weather[index]
        let container = FacadeGrayCont(date: forecast.dt, humidity: forecast.main.humidity, description: forecast.weather.first?.description ?? "None", minTemp: forecast.main.temp_min, maxTemp: forecast.main.temp_max)
        contentView.addSubview(container)
        container.snp.makeConstraints{
            $0.size.equalToSuperview()
        }
    }

    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
