import UIKit
import SnapKit

class DetailEveryDayVC: UIViewController {
    var collectionView: UICollectionView!
    var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    var weatherFDResDublicate: [Forecast]? {
        didSet {
            updateUIForSelectedIndex()
        }
    }
    
    let scView = UIScrollView()
    let scContainer = UIView()
    var dayContainer = UIView()
    var nightContainer = UIView()
    var sunAndMoonLabel = UILabel()
    var sunAndMoonContainer = UIView()
    var sunAndMoonContainerTwo = UIView()
    var qualityCont = UIView()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(dismissView))
        navigationItem.title = "Дневная погода"
        navigationItem.leftBarButtonItem?.tintColor = .blackText
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DetailEveryDayCell.self, forCellWithReuseIdentifier: "DetailEveryDayCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.snp.top).offset(150)
        }
        
        // Создание scView и scContainer
        scView.backgroundColor = .white
        scContainer.backgroundColor = .clear
        
        // Сначала добавляем scView в основной view
        view.addSubview(scView)
        
        // Затем добавляем scContainer в scView
        scView.addSubview(scContainer)

        // Ограничения для scView
        scView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        // Ограничения для scContainer
        scContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        // Добавляем dayContainer в scContainer
        dayContainer = createContainer(
            isDay: true,
            temp: 20.0,
            nameWeather: "Cloudy",
            feelTemp: 18.0,
            wind: 5.0,
            humidity: 75,
            clouds: 80
        )
        scContainer.addSubview(dayContainer)

        dayContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(344)
        }
        
        // Добавляем nightContainer в scContainer
        nightContainer = createContainer(
            isDay: false,
            temp: 20.0,
            nameWeather: "Cloudy",
            feelTemp: 18.0,
            wind: 5.0,
            humidity: 75,
            clouds: 80
        )
        scContainer.addSubview(nightContainer)

        nightContainer.snp.makeConstraints {
            $0.top.equalTo(dayContainer.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(344)
        }
        
        // Добавляем sunAndMoonLabel в scContainer
        sunAndMoonLabel = createLabel(text: "Солнце и луна", font: UIFont.rubik(fontType: .medium, size: 18), color: .blackText)
        scContainer.addSubview(sunAndMoonLabel)
        sunAndMoonLabel.snp.makeConstraints {
            $0.top.equalTo(nightContainer.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        // Добавляем sunAndMoonContainer в scContainer
        sunAndMoonContainer = createSunMoonContainer(allTime: "14:27", sunrise: "22:22", sunset: "08:22", imageName: "sun")
        scContainer.addSubview(sunAndMoonContainer)
        sunAndMoonContainer.snp.makeConstraints {
            $0.top.equalTo(sunAndMoonLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(200)
            $0.height.equalTo(120)
//            $0.bottom.equalToSuperview().offset(-20)
        }
        
        sunAndMoonContainerTwo = createSunMoonContainer(allTime: "14:27", sunrise: "22:22", sunset: "08:22", imageName: "mooon")
        scContainer.addSubview(sunAndMoonContainerTwo)
        sunAndMoonContainerTwo.snp.makeConstraints {
            $0.top.equalTo(sunAndMoonContainer.snp.top)
            $0.leading.equalTo(sunAndMoonContainer.snp.trailing).offset(10)
            $0.width.equalTo(200)
            $0.height.equalTo(120)
        }
        
        qualityCont = createAirQualityCont()
        scContainer.addSubview(qualityCont)
        qualityCont.snp.makeConstraints {
            $0.top.equalTo(sunAndMoonContainer.snp.bottom).offset(5)
            $0.leading.equalTo(sunAndMoonContainer.snp.leading)
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview().offset(-20)
        }

        updateUIForSelectedIndex()
    }
    
    
    //MARK: - updateUIForSelectedIndex
    func updateUIForSelectedIndex() {
        guard let weather = weatherFDResDublicate, selectedIndexPath.row < weather.count else { return }
        let forecast = weather[selectedIndexPath.row]
        
        //MARK: - day/night container
        // Убираем старые контейнеры, если они есть
        dayContainer.removeFromSuperview()
        nightContainer.removeFromSuperview()

        // Создаём и добавляем новый dayContainer
        dayContainer = createContainer(
            isDay: true,
            temp: forecast.main.temp_max,
            nameWeather: forecast.weather.first?.main ?? "",
            feelTemp: forecast.main.feels_like,
            wind: forecast.wind.speed,
            humidity: forecast.main.humidity,
            clouds: forecast.clouds.all
        )
        scContainer.addSubview(dayContainer)
        dayContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(344)
        }

        // Создаём и добавляем новый nightContainer
        nightContainer.removeFromSuperview()
        nightContainer = createContainer(
            isDay: false,
            temp: forecast.main.temp_min,
            nameWeather: forecast.weather.first?.main ?? "",
            feelTemp: forecast.main.feels_like,
            wind: forecast.wind.speed,
            humidity: forecast.main.humidity,
            clouds: forecast.clouds.all
        )
        scContainer.addSubview(nightContainer)
        nightContainer.snp.makeConstraints {
            $0.top.equalTo(dayContainer.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(344)
        }
        
        //MARK: - sunAndMoon
        // Убираем старую метку и контейнер, если они есть
        sunAndMoonLabel.removeFromSuperview()
        sunAndMoonContainer.removeFromSuperview()
        sunAndMoonContainerTwo.removeFromSuperview()
        qualityCont.removeFromSuperview()

        // Создаём и добавляем новый sunAndMoonLabel
        sunAndMoonLabel = createLabel(text: "Солнце и луна", font: UIFont.rubik(fontType: .medium, size: 18), color: .blackText)
        scContainer.addSubview(sunAndMoonLabel)
        sunAndMoonLabel.snp.makeConstraints {
            $0.top.equalTo(nightContainer.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
        }

        // Создаём и добавляем новый sunAndMoonContainer
        sunAndMoonContainer = createSunMoonContainer(allTime: "14:27", sunrise: "05:19", sunset: "19:46", imageName: "sun")
        scContainer.addSubview(sunAndMoonContainer)
        sunAndMoonContainer.snp.makeConstraints {
            $0.top.equalTo(sunAndMoonLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(200)
            $0.height.equalTo(120)
//            $0.bottom.equalToSuperview().offset(-20)
        }
        
        sunAndMoonContainerTwo = createSunMoonContainer(allTime: "14:27", sunrise: "20:02", sunset: "04:22", imageName: "mooon")
        scContainer.addSubview(sunAndMoonContainerTwo)
        sunAndMoonContainerTwo.snp.makeConstraints {
            $0.top.equalTo(sunAndMoonContainer.snp.top)
            $0.leading.equalTo(sunAndMoonContainer.snp.trailing).offset(10)
            $0.width.equalTo(200)
            $0.height.equalTo(120)
        }
        
        qualityCont = createAirQualityCont()
        scContainer.addSubview(qualityCont)
        qualityCont.snp.makeConstraints {
            $0.top.equalTo(sunAndMoonContainer.snp.bottom).offset(5)
            $0.leading.equalTo(sunAndMoonContainer.snp.leading)
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview().offset(-20)
        }

        // Применяем изменения к layout
        scContainer.layoutIfNeeded()
    }
    
    
    //MARK: - dismiss
    @objc func dismissView() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension DetailEveryDayVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherFDResDublicate?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DetailEveryDayCell", for: indexPath
        ) as? DetailEveryDayCell else {
            return UICollectionViewCell()
        }
        
        cell.weatherFDResDublicate = weatherFDResDublicate
        cell.index = indexPath.row
        cell.updateSelectionState(isSelected: indexPath == selectedIndexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousSelectedIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        collectionView.reloadItems(at: [previousSelectedIndexPath, selectedIndexPath])
        
        updateUIForSelectedIndex()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 40)
    }
}
