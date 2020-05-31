//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

open class PopoverSegue: NSObject {

    private(set) var navigVC: UINavigationController
    public let viewController: UIViewController
    public let originPoint: CGPoint

    public init(viewController: UIViewController, originPoint: CGPoint) {
        self.viewController = viewController
        self.originPoint = originPoint

        guard let window = UIApplication.shared.keyWindow else { fatalError("Crash! Missing keyWindow.") }

        self.navigVC = UINavigationController(
            rootViewController: PopoverContainerViewController(
                containerController: viewController,
                originPoint: originPoint,
                windowForNavigation: window
            )
        )
        navigVC.setNavigationBarHidden(true, animated: false)
        navigVC.modalPresentationStyle = .custom
        navigVC.modalTransitionStyle = .crossDissolve
    }

    open func performInWindow(_ window: UIWindow, completed: @escaping () -> Void) {
        guard let presenter = window.rootViewController else { return }

        if presenter.presentedViewController == nil {
            presenter.present(navigVC, animated: true, completion: completed)
        } else {
            presenter.dismiss(animated: false) {
                presenter.present(self.navigVC, animated: true, completion: completed)
            }
        }
    }
}
