import UIKit
import SnapKit

class FacadeBlueCont: UIView {
    
    //MARK: - init
    init(temp: Double, minTemp: Double,
         maxTemp: Double, sunrise: String,
         sunset: String, cloudy: Int,
         wind: Double, humidity: Double,
         date: String, description: String) {
        super .init(frame: .zero)
        
        let sunLineImage = UIImageView()
        sunLineImage.image = .sunLine
        sunLineImage.contentMode = .scaleAspectFit
        addSubview(sunLineImage)
        sunLineImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-70)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        //sunrise
        let sunriseImage = createImage(nameImage: "sunrise")
        addSubview(sunriseImage)
        sunriseImage.snp.makeConstraints{
            $0.top.equalTo(sunLineImage.snp.bottom).offset(5)
            $0.leading.equalTo(sunLineImage.snp.leading)
            $0.size.equalTo(17)
        }
        let sunriseValue = createLabel(text: sunrise, font: UIFont.rubik(fontType: .medium, size: 14))
        addSubview(sunriseValue)
        sunriseValue.snp.makeConstraints{
            $0.top.equalTo(sunriseImage.snp.bottom).offset(5)
            $0.leading.equalTo(sunriseImage.snp.leading).offset(-7)
        }
        
        //sunset
        let sunsetImage = createImage(nameImage: "sunset")
        addSubview(sunsetImage)
        sunsetImage.snp.makeConstraints{
            $0.top.equalTo(sunLineImage.snp.bottom).offset(5)
            $0.trailing.equalTo(sunLineImage.snp.trailing)
            $0.size.equalTo(17)
        }
        let sunsetValue = createLabel(text: sunset, font: UIFont.rubik(fontType: .medium, size: 14))
        addSubview(sunsetValue)
        sunsetValue.snp.makeConstraints{
            $0.top.equalTo(sunsetImage.snp.bottom).offset(5)
            $0.trailing.equalTo(sunsetImage.snp.trailing).offset(7)
        }
        
        //min max
        let minMaxTemp = createLabel(text: "\(minTemp)/\(maxTemp)", font: UIFont.rubik(fontType: .regular, size: 16))
        addSubview(minMaxTemp)
        minMaxTemp.snp.makeConstraints{
            $0.top.equalTo(sunLineImage.snp.top).offset(16)
            $0.centerX.equalTo(sunLineImage.snp.centerX)
        }
        
        //temp
        let mainTemp = createLabel(text: "\(temp)", font: UIFont.rubik(fontType: .medium, size: 36))
        addSubview(mainTemp)
        mainTemp.snp.makeConstraints{
            $0.top.equalTo(minMaxTemp.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        //description
        let desc = createLabel(text: description, font: UIFont.rubik(fontType: .regular, size: 16))
        addSubview(desc)
        desc.snp.makeConstraints{
            $0.top.equalTo(mainTemp.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        //cloudy
        let cloud = createImageLabel(nameImage: "cloudy", text: "\(cloudy)", font: UIFont.rubik(fontType: .regular, size: 14), textColor: .white)
        addSubview(cloud)
        cloud.snp.makeConstraints{
            $0.top.equalTo(desc.snp.bottom).offset(5)
            $0.leading.equalTo(sunriseImage.snp.trailing).offset(35)
            $0.height.equalTo(22)
            $0.width.equalTo(35)
        }
        
        //wind speed
        let wind = createImageLabel(nameImage: "wind", text: "\(wind)", font: UIFont.rubik(fontType: .regular, size: 14), textColor: .white)
        addSubview(wind)
        wind.snp.makeConstraints{
            $0.top.equalTo(cloud.snp.top)
            $0.leading.equalTo(cloud.snp.trailing).offset(22)
            $0.height.equalTo(22)
            $0.width.equalTo(35)
        }
        
        //humidity
        let humidity = createImageLabel(nameImage: "rain", text: "\(humidity)", font: UIFont.rubik(fontType: .regular, size: 14), textColor: .white)
        addSubview(humidity)
        humidity.snp.makeConstraints{
            $0.top.equalTo(wind.snp.top)
            $0.trailing.equalTo(sunsetImage.snp.leading).offset(-35)
            $0.height.equalTo(22)
            $0.width.equalTo(35)
        }
        
        //date
        let date = createLabel(text: date, font: UIFont.rubik(fontType: .regular, size: 16))
        date.textColor = .yellowText
        addSubview(date)
        date.snp.makeConstraints{
            $0.top.equalTo(humidity.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    //MARK: - createImage
    func createImage(nameImage: String) -> UIImageView{
        let image = UIImageView()
        image.image = UIImage(named: nameImage)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }
    
    //MARK: - createLabel
    func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = .white
        return label
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
