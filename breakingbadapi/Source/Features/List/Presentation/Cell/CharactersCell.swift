//
//  CharactersCell.swift
//  breakingbadapi
//
//  Created by David Martin on 7/11/21.
//

import SDWebImage
import UIKit

class CharactersCell: UITableViewCell {
    static let identifier: String = "charactersCell"

    @IBOutlet private var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var avatarImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    private var heightConstraint: CGFloat = 0 {
        didSet {
            self.viewHeightConstraint.constant = self.heightConstraint
        }
    }

    private var model: Character? {
        didSet {
            self.fillData()
        }
    }

    public func callAsFunction(_ viewHeight: CGFloat, _ model: Character) {
        self.heightConstraint = viewHeight / 1.5
        self.model = model
    }

    private func fillData() {
        guard let model = self.model else { return }

        if let avatarUrl = URL(string: model.img ?? "") {
            let placeholderImage = UIImage(named: "placeholder")
            self.avatarImage.sd_setImage(with: avatarUrl, placeholderImage: placeholderImage, options: .continueInBackground)
        }

        if let name = model.name, let nickName = model.nickName {
            self.nameLabel.text = [name, "(\(nickName))"].joined(separator: " ")
        }
    }
}
