//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

final class Example5ViewController: UIViewController {

    private let viewLayout = Example5ViewLayout()

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

extension Example5ViewController {

    private func setupMenuItems() {
        viewLayout.setTitle(text: "Info Bubble")
    }
}

// Arrow shape
