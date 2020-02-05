//
//  DetailPostViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var commentTableView: UITableView!

    let commentController = CommentController()
    var postController: PostController?
    var post: Post?
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        updateViews()
        // Do any additional setup after loading the view.
    }

    private func updateViews() {
        guard let post = post else { return }

        titleLabel.text = post.title
        authorLabel.text = post.author
        descriptionLabel.text = post.description

        if let postId = post.id {
            commentController.fetchCommentsforPost(postID: postId) { (comments, error) in
//                if let error = error {
//                    print("Error: \(error)")
//                }
                if let comments = comments {
                    self.comments = comments
                    DispatchQueue.main.async {
                        self.commentTableView.reloadData()
                    }
                }
            }
        }
    }

}

extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)

        cell.textLabel?.text = self.comments[indexPath.row].description
        cell.detailTextLabel?.text = self.comments[indexPath.row].author

        return cell
    }


}
