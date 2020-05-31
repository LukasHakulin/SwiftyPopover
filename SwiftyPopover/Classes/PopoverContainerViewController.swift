//
//  SwiftyPopover
//
//  Created by Lukas Hakulin.
//  Copyright © 2020 Lukas Hakulin. All rights reserved.
//

import UIKit

public enum ArrowOrientation {
    case top
    case right
    case bottom
    case left
}

open class PopoverContainerViewController: UIViewController {

    // TODO: Dismiss on gotobackground notif and phone rotation notif (if is allowed)
    open var arrowLineWidth: CGFloat { 0.5 }
    open var arrowLineColor: UIColor { .lightGray }
    open var arrowColor: UIColor { .white }
    open var arrowEdgeSize: CGFloat { 12.0 }
    open var safeMargin: UIEdgeInsets { .init(top: 64, left: 16, bottom: 16, right: 16) }
    open var arrowAnimationDuration: Double { 0.12 }
    open var animationDuration: Double { 0.33 }
    open var animationDelay: Double { 0 }
    open var usingSpringWithDamping: CGFloat { 0.6 }
    open var initialSpringVelocity: CGFloat { 1 }
    open var overlayColor: UIColor { UIColor(white: 0, alpha: 0.68) }

    private let originPoint: CGPoint
    private let containerController: UIViewController
    private let window: UIWindow

    public init(containerController: UIViewController, originPoint: CGPoint? = nil, windowForNavigation: UIWindow) {
        self.containerController = containerController
        self.originPoint = originPoint ?? .zero
        self.window = windowForNavigation

        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .overFullScreen
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = overlayColor

        setupContainerControllerAsChild()
        setupModalContainerViewAsSubviewFor(
            container: containerController,
            orientation: getOrientation(fromOriginPoint: originPoint),
            originPoint: originPoint
        )
        displayModalContainer(
            fromOriginPoint: originPoint
        )
        setupGestureRecognizer()
    }

    private func setupContainerControllerAsChild() {
        containerController.willMove(toParent: self)
        addChild(containerController)
        containerController.didMove(toParent: self)
    }

    private func setupModalContainerViewAsSubviewFor(container: UIViewController, orientation: ArrowOrientation, originPoint: CGPoint) {
        view.addSubview(container.view)

        switch orientation {
        case .top, .bottom:
            setupVerticalConstraints(forContainer: container, andOrientation: orientation, fromOriginPoint: originPoint)
        case .right, .left:
            setupHorizontalConstraints(forContainer: container, andOrientation: orientation, fromOriginPoint: originPoint)
        }
    }

    public func setupVerticalConstraints(forContainer container: UIViewController, andOrientation orientation: ArrowOrientation, fromOriginPoint point: CGPoint) {
        var constraints: [NSLayoutConstraint] = []

        let leftDeltaX = window.bounds.width - (window.bounds.width - point.x)
        let rightDeltaX = window.bounds.width - point.x
        let bottomDeltaY = window.bounds.height - point.y
        let horizontalMiddleSize = window.bounds.width / 2
        let horizontalOffset = (leftDeltaX > rightDeltaX ? (horizontalMiddleSize - rightDeltaX) : (horizontalMiddleSize - leftDeltaX) * -1)

        let centerYAnchorConstraint = containerController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: horizontalOffset)
        centerYAnchorConstraint.priority = .init(rawValue: 200)
        centerYAnchorConstraint.isActive = true

        constraints.append(containerController.view.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: safeMargin.left))
        constraints.append(containerController.view.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -safeMargin.right))

        switch orientation {
        case .top:
            constraints.append(containerController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: point.y + arrowEdgeSize))
            constraints.append(containerController.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -safeMargin.bottom))
        case .bottom:
            constraints.append(containerController.view.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: safeMargin.top))
            constraints.append(containerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomDeltaY + arrowEdgeSize)))
        case .left, .right:
            fatalError("Unexpected orientation in setupVerticalConstraints(_:)")
        }

        constraints.forEach {
            $0.priority = .required
            $0.isActive = true
        }
    }

    public func setupHorizontalConstraints(forContainer container: UIViewController, andOrientation orientation: ArrowOrientation, fromOriginPoint point: CGPoint) {
        var constraints: [NSLayoutConstraint] = []

        let rightDeltaX = window.bounds.width - point.x
        let topDeltaY = window.bounds.height - (window.bounds.height - point.y)
        let bottomDeltaY = window.bounds.height - point.y
        let vertialMiddleSize = window.bounds.height / 2
        let verticalOffset = (topDeltaY > bottomDeltaY ? (vertialMiddleSize - bottomDeltaY) : (vertialMiddleSize - topDeltaY) * -1)

        let centerYAnchorConstraint = containerController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: verticalOffset)
        centerYAnchorConstraint.priority = .init(rawValue: 200)
        centerYAnchorConstraint.isActive = true

        constraints.append(containerController.view.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: safeMargin.top))
        constraints.append(containerController.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -safeMargin.bottom))

        switch orientation {
        case .right:
            constraints.append(containerController.view.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: safeMargin.left))
            constraints.append(containerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(rightDeltaX + arrowEdgeSize)))
        case .left:
            constraints.append(containerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: point.x + arrowEdgeSize))
            constraints.append(containerController.view.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -safeMargin.right))
        case .top, .bottom:
            fatalError("Unexpected orientation in setupHorizontalConstraints(_:)")
        }

        constraints.forEach {
            $0.priority = .required
            $0.isActive = true
        }
    }

    private func getOrientation(fromOriginPoint point: CGPoint) -> ArrowOrientation {
        let goalWidthArea = window.bounds.width * 0.2
        let goalHeightArea = window.bounds.height * 0.1

        if point.y < goalHeightArea {
            return .top
        } else if point.y > (window.bounds.height - goalHeightArea) {
            return .bottom
        } else if point.x < goalWidthArea {
            return .left
        } else if point.x > (window.bounds.width - goalWidthArea) {
            return .right
        }

        let topDeltaY = window.bounds.height - (window.bounds.height - point.y)
        let bottomDeltaY = window.bounds.height - point.y

        if topDeltaY > bottomDeltaY {
            return .bottom
        } else {
            return .top
        }
    }

    public func displayModalContainer(fromOriginPoint originPoint: CGPoint) {
        let arrowOrientation = getOrientation(fromOriginPoint: originPoint)

        containerController.view.alpha = 0

        animateArrowShape(fromOriginPoint: originPoint, forOrientation: arrowOrientation) { [weak self] in
            self?.animateContainer(fromOriginPoint: originPoint, forOrientation: arrowOrientation)
        }
    }

    public func animateContainer(fromOriginPoint point: CGPoint, forOrientation orientation: ArrowOrientation) {
        containerController.view.alpha = 0
        containerController.view.layoutIfNeeded()

        switch orientation {
        case .top:
            containerController.view.transform = CGAffineTransform(translationX: 0.0, y: -(containerController.view.frame.height/2)).scaledBy(x: 1, y: 0.01)
        case .right:
            containerController.view.transform = CGAffineTransform(translationX: containerController.view.frame.width/2, y: 0.0).scaledBy(x: 0.01, y: 1)
        case .bottom:
            containerController.view.transform = CGAffineTransform(translationX: 0.0, y: containerController.view.frame.height/2).scaledBy(x: 1, y: 0.01)
        case .left:
            containerController.view.transform = CGAffineTransform(translationX: -(containerController.view.frame.width/2), y: 0.0).scaledBy(x: 0.01, y: 1)
        }

        UIView.animate(
            withDuration: animationDuration,
            delay: animationDelay,
            usingSpringWithDamping: usingSpringWithDamping,
            initialSpringVelocity: initialSpringVelocity,
            options: .curveEaseInOut,
            animations: {
                self.containerController.view.transform = .identity
                self.containerController.view.alpha = 1
            }, completion: { _ in }
        )
    }

    public func animateArrowShape(fromOriginPoint point: CGPoint, forOrientation orientation: ArrowOrientation, completion: @escaping (() -> Void)) {
        let shapeLayer = getShapeLayer(fromBezierPath: getOriginPath(fromOriginPoint: point, andPathComponents: 2))

        CATransaction.begin()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.toValue = getArrowPath(toPoint: point, andOrientation: orientation).cgPath
        pathAnimation.duration = arrowAnimationDuration
        pathAnimation.timingFunction = .init(name: .easeOut)
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = .forwards

        CATransaction.setCompletionBlock(completion)
        view.layer.addSublayer(shapeLayer)
        shapeLayer.add(pathAnimation, forKey: "pathAnimation")
        CATransaction.commit()
    }

    // MARK: - CAShapeLayer support

    public func getShapeLayer(fromBezierPath path: UIBezierPath) -> CAShapeLayer {
        let shapeLayer = shapeLayerWithConfiguratedOptions
        shapeLayer.path = path.cgPath

        return shapeLayer
    }

    public var shapeLayerWithConfiguratedOptions: CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = arrowLineColor.cgColor
        shapeLayer.lineWidth = CGFloat(0.5)
        shapeLayer.backgroundColor = arrowColor.cgColor
        shapeLayer.fillColor = arrowColor.cgColor

        return shapeLayer
    }

    // MARK: - UIBezierPath support

    public func getOriginPath(fromOriginPoint point: CGPoint, andPathComponents pathComponents: Int) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: point)
        for iterator in 1...pathComponents {
            bezierPath.addLine(to: iterator % 2 == 0 ? CGPoint(x: point.x + 0.1, y: point.y + 0.1) : point)
        }
        bezierPath.move(to: point)

        return bezierPath
    }

    public func getArrowPath(toPoint point: CGPoint, andOrientation orientation: ArrowOrientation) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        switch orientation {
        case .top:
            bezierPath.move(to: CGPoint(x: point.x - arrowEdgeSize, y: point.y + arrowEdgeSize))
            bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
            bezierPath.addLine(to: CGPoint(x: point.x + arrowEdgeSize, y: point.y + arrowEdgeSize))
        case .right:
            bezierPath.move(to: CGPoint(x: point.x - arrowEdgeSize, y: point.y - arrowEdgeSize))
            bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
            bezierPath.addLine(to: CGPoint(x: point.x - arrowEdgeSize, y: point.y + arrowEdgeSize))
        case .bottom:
            bezierPath.move(to: CGPoint(x: point.x - arrowEdgeSize, y: point.y - arrowEdgeSize))
            bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
            bezierPath.addLine(to: CGPoint(x: point.x + arrowEdgeSize, y: point.y - arrowEdgeSize))
        case .left:
            bezierPath.move(to: CGPoint(x: point.x + arrowEdgeSize, y: point.y - arrowEdgeSize))
            bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
            bezierPath.addLine(to: CGPoint(x: point.x + arrowEdgeSize, y: point.y + arrowEdgeSize))
        }

        return bezierPath
    }

    // MARK: - Gesture Recognizer support

    public func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PopoverContainerViewController: UIGestureRecognizerDelegate {

    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point = touch.location(in: view)
        return containerController.view.frame.contains(point) == false
    }
}
