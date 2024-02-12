//
//  ModelCell.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 2/1/24.
//

import Foundation
// ModelCell.swift

import UIKit

class ModelCell: UICollectionViewCell {
    static let reuseIdentifier = "ModelCell"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()

        // Enable user interaction for the cell
        self.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let expandedBounds = bounds.inset(by: UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20))
        return expandedBounds.contains(point)
    }


}


// I have a selection of avatars the user can tap on based on the amount they enter. But once I tap on one of the avatars it's hard to push to the next VC after a simple tap. I don't know if the tap location is a small point in each Button but I should be able to tap anywhere inside that Avatar and it should push with ease like a reg button. Here some code snippets of the logic behind the collectionView and the Avatar buttons.

// Why is my avatar buttons not tapping once I tap on the selected button. It takes like ten times of taping on the Button for it to push to the next VC

// I tried finding ways to increase the tap location size and that did not work.
