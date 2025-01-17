//
//  OnboardingPageViewController.swift
//  3Degrees
//

import UIKit
import FLTextView
import TSMarkdownParser

class OnboardingPageViewController: UIPageViewController {
    private var orderedViewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Common.MainColor
        
        dataSource = self

        let staticApi: StaticContentApiProtocol = StaticContentApiController()
        var contentType = StaticContentType.Onboarding
        switch AppController.shared.currentUserMode.value {
        case .Matchmaker:
            contentType = .OnboardingMatchmaker
            break
        case .Single:
            contentType = .OnboardingSingle
            break
        }
        staticApi.getWithType(contentType) { (content) in
            self.orderedViewControllers = content.map({md in self.newContentViewController(md)})
            if let firstViewController = self.orderedViewControllers.first {
                self.setViewControllers([firstViewController],
                                   direction: .Forward,
                                   animated: true,
                                   completion: nil)
            }
        }
    }

    private func newContentViewController(content: String)-> UIViewController {
        let controller = UIViewController()
        let contentView = FLTextView()
        contentView.attributedText = TSMarkdownParser.standardParser().attributedStringFromMarkdown(content)
        contentView.backgroundColor = Constants.Common.MainColor
        contentView.textAlignment = .Center
        controller.view = contentView
        return controller
    }
}

// MARK: UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            AppController.shared.setupMainAppContent()
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return UIViewController()
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}