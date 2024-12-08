import UIKit
import SnapKit

class DetailEveryDayCell: UICollectionViewCell {
    
    var weatherFDResDublicate: [Forecast]? {
        didSet {
            setupWeatherInfo()
        }
    }
        
    var index: Int? {
        didSet {
            setupWeatherInfo()
        }
    }
    
    let container: UIView = {
        let cont = UIView()
        cont.backgroundColor = .white
        cont.layer.cornerRadius = 10
        cont.clipsToBounds = true
        return cont
    }()
    
    let dateLabel = createLabel(text: "", font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(container)
        container.addSubview(dateLabel)
        
        container.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // Настройка текста, который не изменяется
    func setupWeatherInfo() {
        guard let weather = weatherFDResDublicate, let index = index, index > -1, index < weather.count else {
            return
        }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM E"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            
            let forecast = weather[index]
            dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.dt)))
    }
    
    func updateSelectionState(isSelected: Bool) {
        container.backgroundColor = isSelected ? .blueBg : .white
        dateLabel.textColor = isSelected ? .white : .blackText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
