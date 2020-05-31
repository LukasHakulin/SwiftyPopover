//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

final class Example2ViewController: UIViewController {

    private let viewLayout = Example2ViewLayout()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = viewLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMenuItems()
    }
}

extension Example2ViewController {

    private func setupMenuItems() {
        for iterator in 0...33 {
            let button = UIButton()
            button.setTitleColor(.orange, for: .normal)
            button.setTitle(" Orange Button \(iterator) ", for: .normal)
            button.backgroundColor = UIColor.white
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.orange.cgColor
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            viewLayout.addToMenu(item: button)
        }
    }

    @objc func buttonPressed(sender: UIButton) {
        print("Button pressed!")
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// Popover content size is bigger than window
