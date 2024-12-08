import UIKit
import SnapKit

//MARK: - FacadeViewController
class FacadeViewController: UIViewController {
    private let city: String
    var weatherRes: WeatherResponse?
    var weatherTDRes: ForecastResponse?
    var weatherFDRes: [Forecast]?
    var collectionView: UICollectionView!
    
    let moreDetailsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Подробнее на 24 часа", for: .normal)
        btn.setTitleColor(.blackText, for: .normal)
        btn.contentMode = .right
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    let moreEveryDayDetailButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("4 дня", for: .normal)
        btn.setTitleColor(.blackText, for: .normal)
        btn.contentMode = .right
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    let everyDayLabel = createLabel(text: "Ежедневный прогноз", font: UIFont.rubik(fontType: .medium, size: 18), color: .blackText)
    
    //MARK: - init
    init(city: String, weatherRes: WeatherResponse?, weatherTDRes: ForecastResponse?, weatherFDRes: [Forecast]?) {
            self.city = city
            self.weatherRes = weatherRes
            self.weatherTDRes = weatherTDRes
            self.weatherFDRes = weatherFDRes
            super.init(nibName: nil, bundle: nil)
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(FirstFacadeCell.self, forCellWithReuseIdentifier: "FirstFacadeCell")
        collectionView.register(SecondFacadeCell.self, forCellWithReuseIdentifier: "SecondFacadeCell")
        collectionView.register(ThirdFacadeCell.self, forCellWithReuseIdentifier: "ThirdFacadeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        collectionView.addSubview(moreDetailsButton)
        collectionView.addSubview(moreEveryDayDetailButton)
        collectionView.addSubview(everyDayLabel)
        
        moreDetailsButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(280)
            $0.centerX.equalToSuperview().offset(80)
        }
        moreEveryDayDetailButton.snp.makeConstraints{
            $0.top.equalTo(moreDetailsButton.snp.bottom).offset(136)
            $0.centerX.equalToSuperview().offset(140)
        }
        everyDayLabel.snp.makeConstraints{
            $0.top.equalTo(moreEveryDayDetailButton.snp.top).offset(5)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    
    //MARK: - setupUI
    private func setupUI() {
        view.backgroundColor = .white
        
        let nameCity = createLabel(text: city, font: UIFont.rubik(fontType: .medium, size: 22), color: .black)
        view.addSubview(nameCity)
        nameCity.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        
        let buttonCreate = UIButton()
        buttonCreate.setImage(UIImage(systemName: "mappin.circle"), for: .normal)
        buttonCreate.tintColor = .black
        buttonCreate.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        view.addSubview(buttonCreate)
        buttonCreate.snp.makeConstraints {
            $0.top.equalTo(nameCity.snp.top).offset(3)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        let buttonMenu = UIButton()
        buttonMenu.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        buttonMenu.tintColor = .black
//        buttonMenu.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        view.addSubview(buttonMenu)
        buttonMenu.snp.makeConstraints {
            $0.top.equalTo(nameCity.snp.top).offset(3)
            $0.leading.equalToSuperview().offset(20)
        }
        
    }
    
    //MARK: - createTapped
    @objc private func createTapped() {
        guard let parentVC = self.parent as? VCMain else { return }
        let vc = NewGeoVC()
        vc.delegate = parentVC
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
    }
    
    //MARK: - create
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                let itemSizeOne = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(200))
                let itemOne = NSCollectionLayoutItem(layoutSize: itemSizeOne)
                
                let groupSizeOne = NSCollectionLayoutSize(widthDimension: .estimated(500), heightDimension: .absolute(100))
                let groupOne = NSCollectionLayoutGroup.horizontal(layoutSize: groupSizeOne, subitems: [itemOne])
                
                let sectionOne = NSCollectionLayoutSection(group: groupOne)
                sectionOne.orthogonalScrollingBehavior = .continuous
                sectionOne.contentInsets = NSDirectionalEdgeInsets(top: 60, leading: 30, bottom: 20, trailing: 20)
                sectionOne.interGroupSpacing = 20
                return sectionOne
                
            case 1:
                let itemSizeTwo = NSCollectionLayoutSize(widthDimension: .absolute(60), heightDimension: .absolute(100))
                let itemTwo = NSCollectionLayoutItem(layoutSize: itemSizeTwo)
                
                let groupSizeTwo = NSCollectionLayoutSize(widthDimension: .estimated(500), heightDimension: .absolute(100))
                let groupTwo = NSCollectionLayoutGroup.horizontal(layoutSize: groupSizeTwo, subitems: [itemTwo])
                
                let sectionTwo = NSCollectionLayoutSection(group: groupTwo)
                sectionTwo.orthogonalScrollingBehavior = .continuous
                sectionTwo.contentInsets = NSDirectionalEdgeInsets(top: 150, leading: 20, bottom: 20, trailing: 20)
                return sectionTwo
                
            case 2:
                let itemSizeThree = NSCollectionLayoutSize(widthDimension: .absolute(365), heightDimension: .absolute(60))
                let itemThree = NSCollectionLayoutItem(layoutSize: itemSizeThree)
                
                let groupSizeThree = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let groupThree = NSCollectionLayoutGroup.vertical(layoutSize: groupSizeThree, subitems: [itemThree])
                groupThree.interItemSpacing = .fixed(4)
                
                let sectionThree = NSCollectionLayoutSection(group: groupThree)
                sectionThree.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20)
                return sectionThree
                
            default:
                fatalError("Unexpected section index: \(sectionIndex)")
            }
        }
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FacadeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstFacadeCell", for: indexPath) as! FirstFacadeCell
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.weatherResDublicate = weatherRes
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondFacadeCell", for: indexPath) as! SecondFacadeCell
            cell.weatherTDResDublicate = weatherTDRes
            cell.index = indexPath
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdFacadeCell", for: indexPath) as! ThirdFacadeCell
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.weatherFDResDublicate = weatherFDRes
            cell.index = indexPath.row
            return cell
        default:
            fatalError("Unexpected section index: \(indexPath.section)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            let detailsView = DetailVC()
            detailsView.weatherTDResDublicate = weatherTDRes
            let navCont = UINavigationController(rootViewController: detailsView)
            navCont.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

            view.window?.layer.add(transition, forKey: kCATransition)
            present(navCont, animated: false, completion: nil)
        case 2:
            let detailsEDView = DetailEveryDayVC()
            detailsEDView.weatherFDResDublicate = weatherFDRes
            let navCont = UINavigationController(rootViewController: detailsEDView)
            navCont.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

            view.window?.layer.add(transition, forKey: kCATransition)
            present(navCont, animated: false, completion: nil)
        default:
            return
        }
    }
}




//MARK: - FacadeMainScreen
class FacadeMainScreen {
    static func createNewScreen(city: String, weatherRes: WeatherResponse?, weatherTDRes: ForecastResponse?, weatherFDRes: [Forecast]?) -> UIViewController {
        return FacadeViewController(city: city, weatherRes: weatherRes, weatherTDRes: weatherTDRes, weatherFDRes: weatherFDRes)
    }
}

