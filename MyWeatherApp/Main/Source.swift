import UIKit
import SnapKit
import DGCharts

//MARK: - createImage
func createImage(nameImage: String) -> UIImageView{
    let image = UIImageView()
    image.image = UIImage(named: nameImage)
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    return image
}

//MARK: - createLabel
func createLabel(text: String, font: UIFont, color: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = color
    return label
}

//MARK: - setupWeatherInfo
func createImageLabel(nameImage: String, text: String, font: UIFont, textColor: UIColor) -> UIView {
    let cont = UIView()
    
    let image = UIImageView()
    image.image = UIImage(named: nameImage)
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    cont.addSubview(image)
    image.snp.makeConstraints{
        $0.top.equalToSuperview()
        $0.size.equalTo(20)
    }
    
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = textColor
    cont.addSubview(label)
    label.snp.makeConstraints{
        $0.top.equalToSuperview()
        $0.leading.equalTo(image.snp.trailing).offset(3)
    }
    return cont
}

//MARK: - Chart
func createLineChart(in view: UIView, with dataPoints: [Double], labels: [Double], chartTitle: String) {
    // Создаем LineChartView
    let lineChartView = LineChartView()
    lineChartView.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 200)
    lineChartView.chartDescription.text = chartTitle // Заголовок графика
    
    // Настройка данных
    var entries: [ChartDataEntry] = []
    for (index, value) in dataPoints.enumerated() {
        entries.append(ChartDataEntry(x: labels[index], y: value))
    }

    // Создание DataSet
    let dataSet = LineChartDataSet(entries: entries, label: chartTitle)
    dataSet.colors = [NSUIColor.blue] // Цвет линии
    dataSet.circleColors = [NSUIColor.red] // Цвет точек
    dataSet.circleRadius = 4.0

    // Создание LineChartData
    let data = LineChartData(dataSet: dataSet)

    // Установка данных для LineChartView
    lineChartView.data = data

    // Настройка графика (опционально)
    lineChartView.xAxis.labelPosition = .bottom // Метки оси X снизу
    lineChartView.rightAxis.enabled = false // Отключение правой оси
    lineChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
    lineChartView.dragEnabled = false
    lineChartView.isUserInteractionEnabled = false
    

    // Добавляем график в переданное представление
    view.addSubview(lineChartView)
}

//MARK: - createContainer
func createContainer(isDay: Bool, temp: Double, nameWeather: String, feelTemp: Double, wind: Double, humidity: Int, clouds: Int) -> UIView{
    
    let cont = UIView()
    cont.backgroundColor = .grayCont
    cont.layer.cornerRadius = 10
    cont.clipsToBounds = true
    
    let isDayLabel = createLabel(text: isDay ? "День" : "Ночь", font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
    cont.addSubview(isDayLabel)
    isDayLabel.snp.makeConstraints{
        $0.top.equalToSuperview().offset(20)
        $0.leading.equalToSuperview().offset(15)
    }
    
    let temp = createLabel(text: "\(String(temp))°", font: UIFont.rubik(fontType: .medium, size: 30), color: .blackText)
    cont.addSubview(temp)
    temp.snp.makeConstraints{
        $0.top.equalTo(isDayLabel.snp.top)
        $0.centerX.equalToSuperview()
    }
    
    let weatherIcon = createImage(nameImage: nameWeather)
    cont.addSubview(weatherIcon)
    weatherIcon.snp.makeConstraints{
        $0.top.equalTo(temp.snp.top).offset(10)
        $0.trailing.equalTo(temp.snp.leading).offset(-5)
        $0.size.equalTo(26)
    }
    
    let nameWeather = createLabel(text: nameWeather, font: UIFont.rubik(fontType: .medium, size: 18), color: .blackText)
    cont.addSubview(nameWeather)
    nameWeather.snp.makeConstraints{
        $0.top.equalTo(temp.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
    }

    let feelTempCont = createWeatherItem(nameImage: "thermometer", text: "По ощущениям", value: "\(feelTemp)°")
    cont.addSubview(feelTempCont)
    feelTempCont.snp.makeConstraints{
        $0.top.equalTo(nameWeather.snp.bottom).offset(25)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(nameWeather.snp.bottom).offset(55)
    }
    let windCont = createWeatherItem(nameImage: "windDetail", text: "Ветер", value: "\(wind)m/s ЗЮЗ")
    cont.addSubview(windCont)
    windCont.snp.makeConstraints{
        $0.top.equalTo(feelTempCont.snp.bottom).offset(10)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(feelTempCont.snp.bottom).offset(40)
    }
    let sunIndexCont = createWeatherItem(nameImage: "sun", text: "Уф индекс", value: "4 (умерен.)")
    cont.addSubview(sunIndexCont)
    sunIndexCont.snp.makeConstraints{
        $0.top.equalTo(windCont.snp.bottom).offset(10)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(windCont.snp.bottom).offset(40)
    }
    let humidityCont = createWeatherItem(nameImage: "cloud-rain", text: "Дождь", value: "\(humidity)%")
    cont.addSubview(humidityCont)
    humidityCont.snp.makeConstraints{
        $0.top.equalTo(sunIndexCont.snp.bottom).offset(10)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(sunIndexCont.snp.bottom).offset(40)
    }
    let cloudysCont = createWeatherItem(nameImage: "blueCloud", text: "Облачность", value: "\(clouds)%")
    cont.addSubview(cloudysCont)
    cloudysCont.snp.makeConstraints{
        $0.top.equalTo(humidityCont.snp.bottom).offset(10)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(humidityCont.snp.bottom).offset(40)
    }
    
    
    
    return cont
}

func createWeatherItem(nameImage: String, text: String, value: String) -> UIView{
    let cont = UIView()
    let text = createImageLabel(nameImage: nameImage, text: text, font: UIFont.rubik(fontType: .regular, size: 16), textColor: .blackText)
    cont.addSubview(text)
    text.snp.makeConstraints{
        $0.top.equalToSuperview()
        $0.leading.equalToSuperview().offset(15)
        $0.width.equalTo(160)
        $0.height.equalTo(27)
    }
    let value = createLabel(text: value, font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
    cont.addSubview(value)
    value.snp.makeConstraints{
        $0.top.equalTo(text.snp.top)
        $0.trailing.equalToSuperview().offset(-16)
    }
    
    let blueLine = createImage(nameImage: "line")
    cont.addSubview(blueLine)
    blueLine.snp.makeConstraints{
        $0.top.equalTo(value.snp.bottom).offset(5)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(value.snp.bottom).offset(7)
    }
    return cont
}


func createSunMoonContainer(allTime: String, sunrise: String, sunset: String, imageName: String) -> UIView {
    let cont = UIView()
    
    let image = createImage(nameImage: imageName)
    cont.addSubview(image)
    image.snp.makeConstraints{
        $0.top.equalToSuperview().offset(5)
        $0.leading.equalToSuperview().offset(25)
        $0.size.equalTo(22)
    }
    
    let label = createLabel(text: allTime, font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
    cont.addSubview(label)
    label.snp.makeConstraints{
        $0.top.equalTo(image.snp.top)
        $0.leading.equalTo(image.snp.trailing).offset(30)
    }
    
    let firstLine = UIImageView()
    firstLine.image = .line
    firstLine.contentMode = .scaleAspectFill
    firstLine.clipsToBounds = true
    firstLine.tintColor = .blueBg
    cont.addSubview(firstLine)
    firstLine.snp.makeConstraints{
        $0.top.equalTo(image.snp.bottom).offset(10)
        $0.leading.equalTo(cont.snp.leading).offset(3)
        $0.trailing.equalTo(cont.snp.trailing)
        $0.height.equalTo(2)
    }
    
    let sunRiseLabel = createLabel(text: "Восход", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    cont.addSubview(sunRiseLabel)
    sunRiseLabel.snp.makeConstraints{
        $0.top.equalTo(firstLine.snp.bottom).offset(8)
        $0.leading.equalTo(image.snp.leading)
    }
    
    let sunRiseValue = createLabel(text: sunrise, font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
    cont.addSubview(sunRiseValue)
    sunRiseValue.snp.makeConstraints{
        $0.top.equalTo(sunRiseLabel.snp.top)
        $0.leading.equalTo(sunRiseLabel.snp.trailing).offset(15)
    }
    
    let secondLine = UIImageView()
    secondLine.image = .line
    secondLine.tintColor = .blueBg
    secondLine.contentMode = .scaleAspectFill
    secondLine.clipsToBounds = true
    cont.addSubview(secondLine)
    secondLine.snp.makeConstraints{
        $0.top.equalTo(sunRiseLabel.snp.bottom).offset(10)
        $0.leading.equalTo(cont.snp.leading).offset(3)
        $0.trailing.equalTo(cont.snp.trailing)
        $0.height.equalTo(2)
    }
    
    let sunSetLabel = createLabel(text: "Заход", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    cont.addSubview(sunSetLabel)
    sunSetLabel.snp.makeConstraints{
        $0.top.equalTo(secondLine.snp.bottom).offset(8)
        $0.leading.equalTo(image.snp.leading)
    }
    
    let sunSetValue = createLabel(text: sunset, font: UIFont.rubik(fontType: .regular, size: 18), color: .blackText)
    cont.addSubview(sunSetValue)
    sunSetValue.snp.makeConstraints{
        $0.top.equalTo(sunSetLabel.snp.top)
        $0.leading.equalTo(sunRiseValue.snp.leading)
    }
    
    return cont
}

//MARK: - createAirQuality
func createAirQualityCont() -> UIView {
    let cont = UIView()
    
    let qualityValue = createLabel(text: "52", font: UIFont.rubik(fontType: .regular, size: 30), color: .blackText)
    cont.addSubview(qualityValue)
    qualityValue.snp.makeConstraints{
        $0.top.equalTo(cont.snp.top).offset(5)
        $0.leading.equalTo(cont.snp.leading).offset(5)
    }
    
    let qualityCont = UIView()
    qualityCont.backgroundColor = .greenCont
    qualityCont.layer.cornerRadius = 10
    qualityCont.clipsToBounds = true
    cont.addSubview(qualityCont)
    qualityCont.snp.makeConstraints{
        $0.top.equalTo(qualityValue.snp.top).offset(5)
        $0.leading.equalTo(qualityValue.snp.trailing).offset(30)
        $0.height.equalTo(26)
        $0.width.equalTo(96)
    }
    
    let labelForQualityCont = createLabel(text: "Хорошо", font: UIFont.rubik(fontType: .regular, size: 16), color: .white)
    qualityCont.addSubview(labelForQualityCont)
    labelForQualityCont.snp.makeConstraints{
        $0.center.equalToSuperview()
    }
    
    let qualityText = createLabel(text: "Качество воздуха считается \nудовлетворительным и загрязнения\nвоздуха представляются незначительными \nв пределах нормы", font: UIFont.rubik(fontType: .regular, size: 14), color: .grayText)
    qualityText.numberOfLines = 0
    cont.addSubview(qualityText)
    qualityText.snp.makeConstraints{
        $0.top.equalTo(qualityValue.snp.bottom).offset(10)
        $0.leading.equalTo(qualityValue.snp.leading)
    }
    return cont
}
