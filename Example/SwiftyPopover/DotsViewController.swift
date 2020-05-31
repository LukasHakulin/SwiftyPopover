//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit
import SwiftyPopover

final class DotsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = PopoverExampleSwitcher.shared.selectedTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: PopoverExampleSwitcher.shared.selectedColor
        ]

        view.backgroundColor = .white

        let button = DotsButton()
        button.dotsColor = PopoverExampleSwitcher.shared.selectedColor
        button.orientation = .horizontal
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton

        let button01 = DotsButton()
        let button02 = DotsButton()
        let button03 = DotsButton()
        let button04 = DotsButton()
        let button05 = DotsButton()
        let button06 = DotsButton()
        let button07 = DotsButton()
        let button08 = DotsButton()
        let button09 = DotsButton()
        let button10 = DotsButton()
        let button11 = DotsButton()

        [button01, button02, button03, button04, button05, button06, button07, button08, button09, button10, button11].forEach {
            $0.dotsColor = PopoverExampleSwitcher.shared.selectedColor
            $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            view.addSubview($0)
        }

        button01.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        button01.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        button02.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        button02.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        button03.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        button03.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        button04.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        button04.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        button05.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        button05.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        button06.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        button06.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        button07.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        button07.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

        button08.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        button08.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true

        button09.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        button09.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true

        button10.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        button10.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true

        button11.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        button11.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
    }

    @objc func buttonPressed(sender: UIButton) {
        guard let window = UIApplication.shared.keyWindow else { return }

        var originPoint = sender.center
        if (sender.superview?.superview?.superview as? UINavigationBar) != nil {
            originPoint = sender.convert(sender.center, to: view)
        }

        switch PopoverExampleSwitcher.shared.selectedType {
        case .fixed_width_of_popover_screen:
            PopoverSegue(viewController: Example1ViewController(), originPoint: originPoint).performInWindow(window) {}
        case .popover_content_size_is_bigger_than_window:
            PopoverSegue(viewController: Example2ViewController(), originPoint: originPoint).performInWindow(window) {}
        case .unscrollable_popover:
            PopoverSegue(viewController: Example3ViewController(), originPoint: originPoint).performInWindow(window) {}
        case .popover_in_round_shape_info_bubble:
            PopoverSegue(viewController: Example4ViewController(), originPoint: originPoint).performInWindow(window) {}
        case .arrow_shape:
            ArrowPopoverSegue(viewController: Example5ViewController(), originPoint: originPoint).performInWindow(window) {}
        case .customized_popover:
            CustomizedPopoverSegue(viewController: Example6ViewController(), originPoint: originPoint).performInWindow(window) {}
        }
    }
}
