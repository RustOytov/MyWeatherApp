import UIKit

class ViewOnBoard: UIPageViewController, PageNavigationDelegate {
    
    //for animation
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewModel = ViewModelOnBoard()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        if let firstPage = viewModel.pages.first as? FirstViewOnBoard {
            firstPage.viewModel = viewModel
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func navigateToNextPage() {
        if let currentVC = viewControllers?.first,
           let nextVC = viewModel.pageAfter(viewController: currentVC) {
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }
}
extension ViewOnBoard: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.pageAfter(viewController: viewController)
    }
}
