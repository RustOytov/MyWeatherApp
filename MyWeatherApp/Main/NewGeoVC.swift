import UIKit
import SnapKit

class NewGeoVC: UIViewController {
    weak var delegate: PageViewControllerDelegate?

    let nameCity = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueBg
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameCity.frame.height))
        nameCity.leftView = paddingView
        nameCity.leftViewMode = .always
        nameCity.layer.cornerRadius = 15
        nameCity.clipsToBounds = true
        nameCity.backgroundColor = .white
        nameCity.placeholder = "Enter city name"
        view.addSubview(nameCity)
        nameCity.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(60)
        }
        
        let btnSave = UIButton()
        btnSave.setTitle("Save new city", for: .normal)
        btnSave.backgroundColor = .grayCont
        btnSave.setTitleColor(.blackText, for: .normal)
        btnSave.layer.cornerRadius = 10
        btnSave.clipsToBounds = true
        btnSave.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
        view.addSubview(btnSave)
        btnSave.snp.makeConstraints {
            $0.top.equalTo(nameCity.snp.bottom).offset(15)
            $0.size.equalTo(CGSize(width: 150, height: 50))
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func btnSaveTapped() {
        guard let cityName = nameCity.text, !cityName.isEmpty else {
            print("City name is empty!")
            return
        }
        print("City name: \(cityName)")
        var weatherData: WeatherResponse?

        //MARK: - fetchWeatherData
        fetchWeatherData(nameCity: cityName) { data in
            if let data = data {
                weatherData = data
                
                //MARK: - fetchThreeHour
                fetchThreeHour(cityName: cityName) { forecastResponse in
                    if let forecastResponse = forecastResponse {
                        fetchFiveDays(cityName: cityName) { dailyForecasts in
                            guard let forecasts = dailyForecasts else {
                                print("No forecasts available")
                                return
                            }
                            self.delegate?.addPage(FacadeViewController(city: cityName, weatherRes: data, weatherTDRes: forecastResponse, weatherFDRes: forecasts))
                        }
                    } else {
                        print("Failed to fetch forecast data")
                    }
                }
            }
            else {
                print("Не все данные тут")
            }
        }
        
        dismiss(animated: true)
    }
}
