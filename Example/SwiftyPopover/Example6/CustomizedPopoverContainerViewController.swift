//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit
import SwiftyPopover

final class CustomizedPopoverContainerViewController: PopoverContainerViewController {

    override var arrowLineColor: UIColor {
        .purple
    }

    override var arrowColor: UIColor {
        .purple
    }

    override var arrowEdgeSize: CGFloat {
        return 8
    }

    override var safeMargin: UIEdgeInsets {
        .init(top: 64, left: 8, bottom: 16, right: 8)
    }

    override var overlayColor: UIColor {
        UIColor(white: 0, alpha: 0.22)
    }
}
