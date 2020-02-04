//
//  MessageBoardTableViewCell.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MessageBoardTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var tagCollectionView: UICollectionView!
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
    }

    func setCollectionViewDataSourceDelegte(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        tagCollectionView.delegate = dataSourceDelegate
        tagCollectionView.dataSource = dataSourceDelegate
        tagCollectionView.tag = row
        tagCollectionView.reloadData()
    }
}
