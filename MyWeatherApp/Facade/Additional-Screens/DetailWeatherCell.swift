import UIKit
import SnapKit

class DetailWeatherCell: UICollectionViewCell {
    
    var data: Forecast?
    let dateLabel = createLabel(text: "", font: UIFont.rubik(fontType: .medium, size: 18), color: .blackText)
    let timeLabel = createLabel(text: "", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    let tempLabel = createLabel(text: "", font: UIFont.rubik(fontType: .medium, size: 18), color: .blackText)
    let feelTemp = createImageLabel(nameImage: "moonDetail", text: "Преимущественно по ощущению", font: UIFont.rubik(fontType: .regular, size: 14), textColor: .blackText)
    let feelTempValue = createLabel(text: "", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    let wind = createImageLabel(nameImage: "windDetail", text: "Ветер", font: UIFont.rubik(fontType: .regular, size: 14), textColor: .blackText)
    let windValue = createLabel(text: "", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    let humidity = createImageLabel(nameImage: "dropsDetail", text: "Атмосферные осадки", font:  UIFont.rubik(fontType: .regular, size: 14), textColor: .blackText)
    let humidityValue = createLabel(text: "", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    
    let cloudy = createImageLabel(nameImage: "cloudDetail", text: "Облачность", font: UIFont.rubik(fontType: .regular, size: 14), textColor: .blackText)
    let cloudyValue = createLabel(text: "", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    let lineImage = createImage(nameImage: "line")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .grayCont
        setSubiews()
        makeConstraints()
    }
    func setSubiews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(feelTemp)
        contentView.addSubview(feelTempValue)
        contentView.addSubview(wind)
        contentView.addSubview(windValue)
        contentView.addSubview(humidity)
        contentView.addSubview(humidityValue)
        contentView.addSubview(cloudy)
        contentView.addSubview(cloudyValue)
        contentView.addSubview(lineImage)
    }
    func makeConstraints() {
        dateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        timeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(15)
        }
        tempLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(75)
            $0.leading.equalToSuperview().offset(15)
        }
        feelTemp.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(80)
        }
        feelTempValue.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-20)
        }
        wind.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(80)
        }
        windValue.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.trailing.equalToSuperview().offset(-20)
        }
        humidity.snp.makeConstraints{
            $0.top.equalToSuperview().offset(110)
            $0.leading.equalToSuperview().offset(80)
        }
        humidityValue.snp.makeConstraints{
            $0.top.equalToSuperview().offset(110)
            $0.trailing.equalToSuperview().offset(-20)
        }
        cloudy.snp.makeConstraints{
            $0.top.equalToSuperview().offset(135)
            $0.leading.equalToSuperview().offset(80)
        }
        cloudyValue.snp.makeConstraints{
            $0.top.equalToSuperview().offset(135)
            $0.trailing.equalToSuperview().offset(-20)
        }
        lineImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func configure(with data: Forecast) {
        self.data = data
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EE dd/MM"
        dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(data.dt)))
        dateFormatter.dateFormat = "HH.mm"
        timeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(data.dt)))
        
        tempLabel.text = "\(data.main.temp)°"
        feelTempValue.text = "\(data.main.feels_like)°"
        windValue.text = "\(data.wind.speed)"
        humidityValue.text = "\(data.main.humidity)%"
        cloudyValue.text = "\(data.clouds.all)%"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
