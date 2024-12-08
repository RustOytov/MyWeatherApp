import UIKit
import SnapKit

//MARK: - protocol PageViewControllerDelegate
protocol PageViewControllerDelegate: AnyObject {
    func addPage(_ viewController: UIViewController)
}

//MARK: - protocol PageViewControllerDelegate
class VCMain: UIPageViewController {
    
    //для анимации нормальной
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pages: [UIViewController] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dataSource = self
        delegate = self
        
        let firstPage = FirstVC()
        pages = [firstPage]
        
        setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    }
    
    func updatePages(newPages: UIViewController) {
        pages.append(newPages)
        guard let firstPage = pages.first else { return }
        setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
    }
}

//MARK: - DataSource, Delegate
extension VCMain: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
}

//MARK: - PageViewControllerDelegate
extension VCMain: PageViewControllerDelegate {
    func addPage(_ viewController: UIViewController) {
        pages.append(viewController)
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
}
