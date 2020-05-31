//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

final class Example3ViewLayout: UIView {

    private let margin: CGFloat = 3.0

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
        addSubview(stackView)
    }

    private func setupViews() {
        backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = margin

        layer.cornerRadius = 4
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

    }

    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.96).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.96).isActive = true
    }
}

extension Example3ViewLayout {

    func addToMenu(item: UIView) {
        stackView.addArrangedSubview(item)
    }
}
