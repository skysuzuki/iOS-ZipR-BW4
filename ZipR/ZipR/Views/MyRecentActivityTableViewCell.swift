//
//  MyRecentActivityTableViewCell.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import TagListView

class MyRecentActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!

    var post: Post? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let post = post else { return print("No Post!") }
        titleLabel.text = post.title
        tagListView.removeAllTags()
        tagListView.addTags(post.tag?.map({ $0.capitalized }) ?? [])
    }

}
