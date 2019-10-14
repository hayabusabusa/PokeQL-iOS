//
//  UITableView+Extension.swift
//  DiscordTableViewSample
//
//  Created by Yamada Shunya on 2019/08/06.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

private class EmptyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // swiftlint:disable:next function_body_length
    init(frame: CGRect, image: UIImage?, title: String, message: String) {
        super.init(frame: frame)

        // Image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0

        // Labels
        let titleLabel = UILabel()
        titleLabel.textColor = .lightGray
        titleLabel.font = .boldSystemFont(ofSize: 14.0)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0

        let messageLabel = UILabel()
        messageLabel.textColor = .lightGray
        messageLabel.font = .systemFont(ofSize: 13.0)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.alpha = 0

        // StackView
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)

        addSubview(stackView)

        // Autolayout
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])

        if image != nil {
            imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        }

        // Animation
        UIView.animate(withDuration: 0.8) {
            imageView.alpha = 1.0
            titleLabel.alpha = 1.0
            messageLabel.alpha = 1.0
        }
    }

    private func commonInit() {
        backgroundColor = .clear
    }
}

extension UITableView {

    func setEmptyView(itemCount: Int, separatorStyle: UITableViewCell.SeparatorStyle, title: String, message: String, image: UIImage? = nil) {
        if itemCount == 0 {
            // Show emptyView
            let rect = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
            let emptyView = EmptyView(frame: rect, image: image, title: title, message: message)

            self.backgroundView = emptyView
            self.separatorStyle = .none
        } else {
            // Dismiss emptyView
            self.backgroundView = nil
            self.separatorStyle = separatorStyle
        }
    }
}

extension UICollectionView {

    func setEmptyView(itemCount: Int, title: String, message: String, image: UIImage? = nil) {
        if itemCount == 0 {
            // Show emptyView
            let rect = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
            let emptyView = EmptyView(frame: rect, image: image, title: title, message: message)

            self.backgroundView = emptyView
        } else {
            // Dismiss emptyView
            self.backgroundView = nil
        }
    }
}
