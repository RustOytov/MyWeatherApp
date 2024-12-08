import UIKit
import SnapKit

class FirstVC: UIViewController {
    let btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Добавить", for: .normal)
        btn.backgroundColor = .orangeButton
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.addTarget(nil, action: #selector(createTapped), for: .touchUpInside)
        return btn
    }()
    let label = createLabel(text: "               Для начала\n вам нужно добавить город", font: UIFont.rubik(fontType: .regular, size: 26), color: .grayCont)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueBg
        view.addSubview(btn)
        btn.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(180)
            $0.height.equalTo(60)
        }
        label.numberOfLines = 0
        view.addSubview(label)
        label.snp.makeConstraints{
            $0.top.equalTo(btn.snp.top).offset(-80)
            $0.centerX.equalToSuperview()
        }
        
    }
    @objc private func createTapped() {
        guard let parentVC = self.parent as? VCMain else { return }
        let vc = NewGeoVC()
        vc.delegate = parentVC
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
    }
}
