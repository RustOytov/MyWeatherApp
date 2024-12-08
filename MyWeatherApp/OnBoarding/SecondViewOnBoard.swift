import UIKit
import SnapKit

class SecondViewOnBoard: UIViewController {
    
    var viewModel: ViewModelOnBoard?
    var settingData: StartSettings = StartSettings(temperature: "", speedWind: "", timeFormat: "", notification: "")
    
    let cloudOne = setCloud(nameImage: "firstCloud")
    let cloudTwo = setCloud(nameImage: "secondCloud")
    let cloudThree = setCloud(nameImage: "thirdCloud")

    let container = setSettingContainer()
    
    let tempSegmentControl = setSegmentedController(items: ["C","F"])
    let windSpeedSegmentControl = setSegmentedController(items: ["Mi","Km"])
    let timeFormateSegmentControl = setSegmentedController(items: ["12","24"])
    let notificationsSegmentControl = setSegmentedController(items: ["On","Off"])
    
    let buttonSet: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orangeButton
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.setTitle("Установить", for: .normal)
        btn.titleLabel?.font = UIFont.rubik(fontType: .regular, size: 16)
        btn.titleLabel?.textColor = .white
        btn.contentMode = .scaleToFill
        return btn
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueBg
        buttonSet.addTarget(self, action: #selector(buttonSetTapped), for: .touchUpInside)
        timeFormateSegmentControl.selectedSegmentIndex = 1
        setSubviews()
        makeConstraints()
        
    }
    
    //MARK: - setSubviews
    
    func setSubviews() {
        let subviews = [cloudOne, cloudTwo, cloudThree, container, buttonSet, tempSegmentControl, windSpeedSegmentControl, timeFormateSegmentControl, notificationsSegmentControl]
        for i in subviews {
            view.addSubview(i)
        }
    }
    
    //MARK: - makeConstraints
    func makeConstraints() {
        cloudOne.snp.makeConstraints{
            $0.top.equalToSuperview().offset(70)
            $0.leading.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalTo(230)
        }
        cloudTwo.snp.makeConstraints{
            $0.top.equalTo(cloudOne.snp.bottom).offset(25)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(view.snp.trailing).offset(-220)
            $0.height.equalTo(94)
            $0.width.equalTo(182)
        }
        cloudThree.snp.makeConstraints{
            $0.top.equalTo(view.snp.bottom).offset(-166)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(65)
            $0.width.equalTo(216)
        }
        container.snp.makeConstraints{
            $0.top.equalTo(cloudTwo.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(27)
            $0.trailing.equalToSuperview().offset(-27)
            $0.height.equalTo(330)
        }
        buttonSet.snp.makeConstraints{
            $0.top.equalTo(container.snp.bottom).offset(-60)
            $0.leading.equalTo(container.snp.leading).offset(35)
            $0.trailing.equalTo(container.snp.trailing).offset(-35)
            $0.height.equalTo(40)
        }
        tempSegmentControl.snp.makeConstraints{
            $0.top.equalTo(container.snp.top).offset(57)
            $0.leading.equalTo(container.snp.trailing).offset(-110)
            $0.width.equalTo(80)
            $0.height.equalTo(33)
        }
        windSpeedSegmentControl.snp.makeConstraints{
            $0.top.equalTo(tempSegmentControl.snp.bottom).offset(18)
            $0.leading.equalTo(tempSegmentControl.snp.leading)
            $0.size.equalTo(tempSegmentControl.snp.size)
        }
        timeFormateSegmentControl.snp.makeConstraints{
            $0.top.equalTo(windSpeedSegmentControl.snp.bottom).offset(18)
            $0.leading.equalTo(windSpeedSegmentControl.snp.leading)
            $0.size.equalTo(windSpeedSegmentControl.snp.size)
        }
        notificationsSegmentControl.snp.makeConstraints{
            $0.top.equalTo(timeFormateSegmentControl.snp.bottom).offset(18)
            $0.leading.equalTo(timeFormateSegmentControl.snp.leading)
            $0.size.equalTo(timeFormateSegmentControl.snp.size)
        }
    }
    
    //MARK: - buttonSetTapped
    @objc private func buttonSetTapped() {
        settingData = setSettingsData(temp: tempSegmentControl.selectedSegmentIndex, speed: windSpeedSegmentControl.selectedSegmentIndex, time: timeFormateSegmentControl.selectedSegmentIndex, notif: notificationsSegmentControl.selectedSegmentIndex)
        viewModel?.isOnBoardingCompleted()
        
        let mainVC = VCMain()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
        
    }
}

