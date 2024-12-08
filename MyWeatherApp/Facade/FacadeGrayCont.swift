import UIKit
import SnapKit

class FacadeGrayCont: UIView {
    
    init(date: Int, humidity: Int, description: String, minTemp: Double, maxTemp: Double) {
        super.init(frame: .zero)
        
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "dd.MM"
        
        let dateLabel = createLabel(text: dateForamtter.string(from: Date(timeIntervalSince1970: TimeInterval(date))), font: UIFont.rubik(fontType: .regular, size: 16), color: .grayText)
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(10)
        }
        
        let cloudImage = createImage(nameImage: "Clouds")
        addSubview(cloudImage)
        cloudImage.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.leading.equalTo(dateLabel.snp.leading)
            $0.size.equalTo(17)
        }
        
        let humidityValue = createLabel(text: "\(humidity)%", font: UIFont.rubik(fontType: .regular, size: 16), color: .blueBg)
        addSubview(humidityValue)
        humidityValue.snp.makeConstraints{
            $0.top.equalTo(cloudImage.snp.top)
            $0.leading.equalTo(cloudImage.snp.trailing).offset(5)
        }
        
        let arrowImage = createImage(nameImage: "arrow")
        addSubview(arrowImage)
        arrowImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(9)
            $0.width.equalTo(6)
        }
        
        let minMaxLabel = createLabel(text: "\(Int(minTemp))°/\(Int(maxTemp))°", font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
        minMaxLabel.contentMode = .right
        addSubview(minMaxLabel)
        minMaxLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(arrowImage.snp.leading).offset(-75)
            $0.trailing.equalTo(arrowImage.snp.leading).offset(-10)
        }
        
        let descLabel = createLabel(text: description, font: UIFont.rubik(fontType: .regular, size: 16), color: .blackText)
        descLabel.contentMode = .left
        addSubview(descLabel)
        descLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(humidityValue.snp.trailing).offset(5)
        }
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
