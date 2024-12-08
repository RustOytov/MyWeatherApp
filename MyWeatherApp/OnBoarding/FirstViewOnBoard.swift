import UIKit
import SnapKit

class FirstViewOnBoard: UIViewController {
    
    var viewModel: ViewModelOnBoard?
    
    let girlLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = .girl
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    let firstText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
   Разрешить приложению Weather
                  использовать данные 
о местоположении вашего устройства 
"""
        label.textColor = .white
        label.font = UIFont.rubik(fontType: .bold, size: 16)
        label.contentMode = .center
        return label
    }()
    
    let secondText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
  Чтобы получить более точные прогнозы
погоды во время движения или путешествия

Вы можете изменить свой выбор в любое
             время из меню приложения
"""
        label.textColor = .white
        label.font = UIFont.rubik(fontType: .regular, size: 14)
        label.contentMode = .center
        return label
    }()
    
    let orangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Использовать местоположение устройства", for: .normal)
        btn.titleLabel?.font = UIFont.rubik(fontType: .bold, size: 14)
        btn.backgroundColor = .orangeButton
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()
    
    let secondButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        btn.backgroundColor = .clear
        btn.titleLabel?.font = UIFont.rubik(fontType: .regular, size: 16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueBg
        setSubviews()
        makeConstraints()
        
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
    }
    
    func setSubviews() {
        let subviews = [girlLogo, firstText, secondText, orangeButton, secondButton]
        for i in subviews {
            view.addSubview(i)
        }
    }
    
    func makeConstraints() {
        girlLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(135)
            $0.top.equalToSuperview().offset(148)
            $0.height.equalTo(196)
            $0.width.equalTo(180)
        }
        firstText.snp.makeConstraints{
            $0.top.equalTo(girlLogo.snp.bottom).offset(55)
            $0.centerX.equalToSuperview()
        }
        secondText.snp.makeConstraints{
            $0.top.equalTo(firstText.snp.bottom).offset(55)
            $0.centerX.equalToSuperview()
        }
        orangeButton.snp.makeConstraints{
            $0.top.equalTo(secondText.snp.bottom).offset(44)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        secondButton.snp.makeConstraints{
            $0.top.equalTo(orangeButton.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        }
    }
    @objc private func secondButtonTapped() {
        viewModel?.goToNextPage()
    }
}
