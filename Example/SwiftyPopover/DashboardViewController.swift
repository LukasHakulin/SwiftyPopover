//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Swifty Popover Examples"

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 8.0

        add(stackView: stackView)
        addButtons(toStackView: stackView)
    }

    private func add(stackView: UIStackView) {
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }

    private func addButtons(toStackView stackView: UIStackView) {
        let button01 = DashboardButton(title: "Fixed width of popover screen", exampleType: .fixed_width_of_popover_screen, color: .red)
        let button02 = DashboardButton(title: "Popover content size is bigger than window", exampleType: .popover_content_size_is_bigger_than_window, color: .blue)
        let button03 = DashboardButton(title: "Unscrollable popover", exampleType: .unscrollable_popover, color: .green)
        let button04 = DashboardButton(title: "Popover in round shape - info Bubble", exampleType: .popover_in_round_shape_info_bubble, color: .cyan)
        let button05 = DashboardButton(title: "Arrow shape", exampleType: .arrow_shape, color: .orange)
        let button06 = DashboardButton(title: "Customized popover", exampleType: .customized_popover, color: .purple)

        [button01, button02, button03, button04, button05, button06].forEach {
            $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            stackView.addArrangedSubview($0)
        }
    }

    @objc func buttonPressed(sender: DashboardButton) {
        PopoverExampleSwitcher.shared.selectedType = sender.exampleType
        PopoverExampleSwitcher.shared.selectedColor = sender.titleColor(for: .normal) ?? .blue
        PopoverExampleSwitcher.shared.selectedTitle = sender.titleLabel?.text ?? ""
        navigationController?.pushViewController(DotsViewController(), animated: true)
    }
}

final class DashboardButton: UIButton {

    let exampleType: ExampleType

    init(title: String, exampleType: ExampleType, color: UIColor) {
        self.exampleType = exampleType
        super.init(frame: .zero)

        layer.borderColor = color.cgColor
        layer.borderWidth = 1.0
        setTitleColor(color, for: .normal)
        setTitle(title, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
