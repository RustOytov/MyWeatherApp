import UIKit
import SnapKit
import DGCharts

class DetailVC: UIViewController {
    
    var weatherTDResDublicate: ForecastResponse?
    var index: Int = 0
    var collectionView: UICollectionView!
    var weatherResult: [Forecast] = []
    var values: [Double] = []
    var labels: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(dismissView))
        navigationItem.title = "Прогноз на 24 часа"
        navigationItem.leftBarButtonItem?.tintColor = .blackText
        
        // Обработка данных для графика
        if let weatherTDResDublicate = weatherTDResDublicate {
            weatherResult = changeWeatherData(data: weatherTDResDublicate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH.mm"
            // Преобразование данных для графика
            for forecast in weatherResult {
                values.append(forecast.main.temp)
                labels.append(Double(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.dt)))) ?? 0.00)
            }
        } else {
            print("Error: weatherTDResDublicate is nil")
        }
        
        // Создание CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DetailWeatherCell.self, forCellWithReuseIdentifier: "detailWeatherCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .grayCont
        view.addSubview(collectionView)
        
        // Создание графика
        createLineChart(in: self.view, with: values, labels: labels, chartTitle: "Прогноз температуры")
        makeConstraints()
    }
    
    // MARK: - makeConstraints
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height / 3)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - changeWeatherData
    func changeWeatherData(data: ForecastResponse) -> [Forecast] {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        let dateNow = dateFormatter.string(from: today)
        var forecastsForDay: [Forecast] = []
        
        for forecast in data.list {
            let formattedDate = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.dt)))
            if formattedDate == dateNow {
                forecastsForDay.append(forecast)
            }
        }
        return forecastsForDay
    }
    
    // MARK: - dismissView
    @objc func dismissView() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - createLineChart
    func createLineChart(in view: UIView, with dataPoints: [Double], labels: [Double], chartTitle: String) {
        let lineChartView = LineChartView()
        lineChartView.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 200)
        
        var entries: [ChartDataEntry] = []
        for (index, value) in dataPoints.enumerated() {
            entries.append(ChartDataEntry(x: labels[index], y: value))
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: chartTitle)
        dataSet.colors = [NSUIColor.blueBg]
        dataSet.circleColors = [NSUIColor.blueBorder]
        dataSet.circleRadius = 4.0
        
        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.rightAxis.enabled = false
        lineChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        lineChartView.isUserInteractionEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        view.addSubview(lineChartView)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "detailWeatherCell", for: indexPath
        ) as? DetailWeatherCell else {
            return UICollectionViewCell()
        }
        let weather = weatherResult[indexPath.row]
        cell.configure(with: weather)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
}
