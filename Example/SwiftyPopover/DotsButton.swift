//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//
import UIKit

final class DotsButton: UIButton {

    var orientation: NSLayoutConstraint.Axis = .vertical {
        didSet {
            stackView.axis = orientation
        }
    }
    var dotsColor: UIColor = .black {
        didSet {
            stackView.arrangedSubviews.forEach { $0.backgroundColor = dotsColor }
        }
    }

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = orientation
        stackView.spacing = 3
        stackView.isUserInteractionEnabled = false
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true

        [UIView(), UIView(), UIView()].forEach {
            $0.isUserInteractionEnabled = false
            $0.backgroundColor = dotsColor
            $0.layer.cornerRadius = 4
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: 8).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 8).isActive = true
            stackView.addArrangedSubview($0)
        }
    }
}
