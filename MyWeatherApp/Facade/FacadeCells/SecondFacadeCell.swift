import UIKit
import SnapKit

//MARK: - SecondFacadeCell
class SecondFacadeCell: UICollectionViewCell {
    var weatherTDResDublicate: ForecastResponse? {
        didSet {
            setupWeatherInfo()
        }
    }
    var index: IndexPath? {
        didSet {
            setupWeatherInfo()
        }
    }
    

    //MARK: - createCellCont
    func createCellCont(contentV: UIView, timeLabels: String, tempLabels: String, background: String, textColor: String, nameImage: String) -> UIView {
        let container: UIView = {
            let cont = UIView()
            cont.backgroundColor = UIColor(named: background)
            cont.layer.cornerRadius = 20
            cont.clipsToBounds = true
            cont.layer.borderWidth = 2
            cont.layer.borderColor = UIColor(named: "blue-border")?.cgColor
            
            let timeLabel = UILabel()
            timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            timeLabel.textColor = UIColor(named: textColor)
            timeLabel.text = timeLabels
            cont.addSubview(timeLabel)
            timeLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(15)
                $0.centerX.equalToSuperview()
            }
            
            let tempLabel = UILabel()
            tempLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            tempLabel.textColor = UIColor(named: textColor)
            tempLabel.text = tempLabels
            cont.addSubview(tempLabel)
            tempLabel.snp.makeConstraints {
                $0.top.equalTo(cont.snp.bottom).offset(-25)
                $0.centerX.equalToSuperview()
            }
            
            let weatherIcon = UIImageView()
            weatherIcon.image = UIImage(named: nameImage)
            cont.addSubview(weatherIcon)
            weatherIcon.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.height.equalTo(16)
                $0.width.equalTo(20)
            }
            
            return cont
        }()
        contentV.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        return container
    }

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setupWeatherInfo
    private func setupWeatherInfo() {
        guard let weather = weatherTDResDublicate, let index = index else {
            return
        }
        let forecast = weather.list[index.row]
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let currentDate = Date()
//        let currentTime = formatter.string(from: currentDate)

        if formatter.string(from: date) == "18:00" {
            createCellCont(contentV: contentView, timeLabels: formatter.string(from: date), tempLabels: "\(forecast.main.temp)", background: "blue-bg", textColor: "gray-cont", nameImage: forecast.weather.first?.main ?? "Clouds")
        } else {
            createCellCont(contentV: contentView, timeLabels: formatter.string(from: date), tempLabels: "\(forecast.main.temp)", background: "gray-cont", textColor: "black-text", nameImage: forecast.weather.first?.main ?? "Clouds")
        }
    }
}
