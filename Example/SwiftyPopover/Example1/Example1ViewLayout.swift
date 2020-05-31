//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

final class Example1ViewLayout: UIView {

    private let margin: CGFloat = 3.0

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    init() {
        super.init(frame: .zero)
        addViews()
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    private func setupViews() {
        backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = margin

        layer.cornerRadius = 8
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

         // MARK: - Prefered constant width for container ViewController
        widthAnchor.constraint(equalToConstant: 280).isActive = true
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: margin).isActive = true

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true

        let constraint = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.0)
        constraint.priority = .init(rawValue: 999)
        constraint.isActive = true

        scrollView.setContentHuggingPriority(.required, for: .horizontal)
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        scrollView.setContentHuggingPriority(.required, for: .vertical)
        stackView.setContentHuggingPriority(.required, for: .vertical)
    }
}

extension Example1ViewLayout {

    func addToMenu(item: UIView) {
        stackView.addArrangedSubview(item)
    }
}
