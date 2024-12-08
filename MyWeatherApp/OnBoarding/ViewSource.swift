import UIKit
import SnapKit

//MARK: - setCloud

func setCloud(nameImage: String) -> UIImageView {
    let cloud = UIImageView()
    cloud.image = UIImage(named: nameImage)
    cloud.contentMode = .scaleAspectFill
    return cloud
}
//MARK: - setSecondLabel

func setSecondLabel(text: String) -> UILabel{
    let label = UILabel()
    label.text = text
    label.font = UIFont.rubik(fontType: .regular, size: 16)
    label.textColor = .grayText
    return label
}

//MARK: - setSettingContainer
func setSettingContainer() -> UIView {
    let cont = UIView()
    cont.backgroundColor = .grayCont
    cont.layer.cornerRadius = 10
    cont.clipsToBounds = true
    cont.contentMode = .scaleAspectFill
    
    let nameCont = UILabel()
    nameCont.text = "Настройки"
    nameCont.textColor = .blackText
    nameCont.font = UIFont.rubik(fontType: .bold, size: 18)
    cont.addSubview(nameCont)
    nameCont.snp.makeConstraints{
        $0.top.equalToSuperview().offset(27)
        $0.leading.equalToSuperview().offset(20)
    }
    
    let temperature = setSecondLabel(text: "Температура")
    cont.addSubview(temperature)
    temperature.snp.makeConstraints{
        $0.top.equalTo(nameCont.snp.bottom).offset(25)
        $0.leading.equalTo(nameCont)
    }
    
    let windSpeed = setSecondLabel(text: "Скорость ветра")
    cont.addSubview(windSpeed)
    windSpeed.snp.makeConstraints{
        $0.top.equalTo(temperature.snp.bottom).offset(25)
        $0.leading.equalTo(temperature)
    }
    
    let timeFormat = setSecondLabel(text: "Формат времени")
    cont.addSubview(timeFormat)
    timeFormat.snp.makeConstraints{
        $0.top.equalTo(windSpeed.snp.bottom).offset(25)
        $0.leading.equalTo(windSpeed)
    }
    
    let notifications = setSecondLabel(text: "Уведомления")
    cont.addSubview(notifications)
    notifications.snp.makeConstraints{
        $0.top.equalTo(timeFormat.snp.bottom).offset(25)
        $0.leading.equalTo(timeFormat)
    }
    return cont
}

func setSegmentedController(items: [String]) -> UISegmentedControl {
    let contr = UISegmentedControl(items: items)
    contr.selectedSegmentIndex = 0
    contr.backgroundColor = .pinkButton
    contr.selectedSegmentTintColor = .blueBg
    let attributeNormal: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.black
    ]
    let attributeSelected: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.white
    ]
    contr.setTitleTextAttributes(attributeNormal, for: .normal)
    contr.setTitleTextAttributes(attributeSelected, for: .selected)
    return contr
}

//MARK: - setSwitch
func setSwitch() -> UISwitch {
    let sw = UISwitch()
    sw.thumbTintColor = .pinkButton
    sw.onTintColor = .blueBg
    sw.tintColor = .blueButton
    return sw
}

//MARK: - setSettingsData
func setSettingsData(temp: Int, speed: Int, time: Int, notif: Int) -> StartSettings{
    var result: StartSettings = StartSettings(temperature: "", speedWind: "", timeFormat: "", notification: "")
    if temp == 1 { result.temperature = "F" } else { result.temperature = "C" }
    if speed == 1 { result.speedWind = "Km" } else { result.speedWind = "Mi" }
    if time == 1 { result.timeFormat = "24" } else { result.timeFormat = "12" }
    if notif == 1 { result.notification = "true" } else { result.notification = "false" }
    return result
}
