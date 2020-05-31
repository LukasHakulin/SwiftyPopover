//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit
import SwiftyPopover

final class ArrowPopoverSegue: PopoverSegue {

    override func performInWindow(_ window: UIWindow, completed: @escaping () -> Void) {
        let navigVC = UINavigationController(
            rootViewController: ArrowPopoverContainerViewController(
                containerController: viewController,
                originPoint: originPoint,
                windowForNavigation: window
            )
        )
        navigVC.setNavigationBarHidden(true, animated: false)
        navigVC.modalPresentationStyle = .custom
        navigVC.modalTransitionStyle = .crossDissolve

        guard let presenter = window.rootViewController else { return }

        if presenter.presentedViewController == nil {
            presenter.present(navigVC, animated: true, completion: completed)
        } else {
            presenter.dismiss(animated: false) {
                presenter.present(navigVC, animated: true, completion: completed)
            }
        }
    }
}
