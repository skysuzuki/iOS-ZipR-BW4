//
//  MessageBoardTableViewCell.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import TagListView

class MessageBoardTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var tagListView: TagListView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var commentNumberLabel: UILabel!

    var post: Post? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let post = post else { return print("No Post!") }
        authorLabel.text = post.author
        titleLabel.text = post.title
        tagListView.addTags(post.tag ?? [])
    }
}
