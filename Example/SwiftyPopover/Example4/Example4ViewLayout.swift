//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

final class Example4ViewLayout: UIView {

    private let margin: CGFloat = 20.0
    private let label = UILabel()

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
        addSubview(label)
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .red
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false

        label.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: margin).isActive = true
    }
}

extension Example4ViewLayout {

    func setTitle(text: String) {
        label.text = text
    }
}
