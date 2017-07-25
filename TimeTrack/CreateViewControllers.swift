//
//  CreateViewControllers.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/25/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class CreateViewControllers: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    lazy var VCList: [UIViewController] = {
        return [
            self.VCInstance(name: "LocationVC"),
            self.VCInstance(name: "TimeVC"),
            self.VCInstance(name: "ConfirmationVC")]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "AddGroups", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        if let LocationVC = VCList.first {
            setViewControllers([LocationVC], direction: .forward, animated: true, completion: nil)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCList.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return VCList.last
        }
        guard VCList.count > previousIndex else {
            return nil
        }
        return VCList[previousIndex]
    }
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCList.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < VCList.count else {
            return VCList.first
        }
        guard VCList.count > nextIndex else {
            return nil
        }
        return VCList[nextIndex]
    }
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
       return VCList.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCList.index(of: firstViewController) else {
                    return 0
        }
        return firstViewControllerIndex
    }
    
}
