//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

enum ExampleType {
    case fixed_width_of_popover_screen
    case popover_content_size_is_bigger_than_window
    case unscrollable_popover
    case popover_in_round_shape_info_bubble
    case arrow_shape
    case customized_popover
}

final class PopoverExampleSwitcher {

    var selectedType: ExampleType = .fixed_width_of_popover_screen
    var selectedColor: UIColor = .red
    var selectedTitle: String = ""

    static let shared = PopoverExampleSwitcher()

    private init() {}
}
