//
//  MyRecentActivityTableViewCell.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MyRecentActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let post = post else { return print("No Post!") }
        testLabel.text = post.title
    }

}
