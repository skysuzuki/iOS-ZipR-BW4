//
//  MessageBoardTableViewCell.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import TagListView

protocol MessageBoardTableViewCellDelegate {
    func commentButtonWasPressed(_ messageBoardCell: MessageBoardTableViewCell)
}

class MessageBoardTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var tagListView: TagListView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var flagPostButton: UIButton!

    var delegate: MessageBoardTableViewCellDelegate?
    var post: Post? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let post = post else { return print("No Post!") }
        authorLabel.text = post.author
        titleLabel.text = post.title
        dateLabel.text = dateString(from: post.date)
        tagListView.removeAllTags()
        tagListView.addTags(post.tag?.map({ $0.capitalized }) ?? [])
    }

    private func dateString(from dateString: String) -> String {
        guard let timeInterval = TimeInterval(dateString) else { return "" }
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }

    @IBAction func commentButtonPressed(_ sender: UIButton) {
        delegate?.commentButtonWasPressed(self)
    }

    @IBAction func flagButtonPressed(_ sender: UIButton) {
        flagPostButton.isSelected.toggle()
    }
}
