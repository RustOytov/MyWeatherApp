import UIKit
import SnapKit

protocol PageNavigationDelegate: AnyObject {
    func navigateToNextPage()
}

class ViewModelOnBoard {
    private(set) var pages: [UIViewController]
    
    weak var delegate: PageNavigationDelegate?
    
    init() {
        pages = [FirstViewOnBoard(), SecondViewOnBoard()]
    }
    
    func goToNextPage() {
        delegate?.navigateToNextPage()
    }
    
    func pageAfter(viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController),
              currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func isOnBoardingCompleted() {
        UserDefaults.standard.set(true, forKey: "onboardingCompleted")
    }
}
