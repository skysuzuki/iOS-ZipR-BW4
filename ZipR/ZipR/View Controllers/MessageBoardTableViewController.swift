//
//  MessageBoardTableViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MessageBoardTableViewController: UITableViewController {

    var postController: PostController?
    var usersLat: String = "0"
    var usersLong: String = "0"
    var localPosts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(updateViews), for: .valueChanged)
        self.refreshControl = refreshController
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: NSNotification.Name(rawValue: "UserWasLoggedIn"), object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: NSNotification.Name(rawValue: "Deletion"), object: nil)
    }

    @objc func updateViews() {
        print("Got the notification")
        guard let postController = postController else { return }
        postController.fetchPosts { (error) in
            if let _ = error {
                print("Error")
            } else {
                self.usersLat = postController.user?.latitude ?? ""
                self.usersLong = postController.user?.longitude ?? ""
                self.localPosts = postController.parsePosts(lat: self.usersLat, long: self.usersLong)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localPosts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBoardCell", for: indexPath) as? MessageBoardTableViewCell else {
            return UITableViewCell()
        }

        cell.post = localPosts[indexPath.row]
        cell.delegate = self
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let detailVC = segue.destination as? CreateMessageBoardViewController {
            if segue.identifier == "ModalCreateMessageBoardSegue" {
                detailVC.postController = self.postController
                detailVC.delegate = self
            }
        } else if let detailVC = segue.destination as? DetailPostViewController {
            if segue.identifier == "ModalDetailPostSegue" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.postController = self.postController
                    detailVC.post = self.localPosts[indexPath.row]
                }
            } else if segue.identifier == "ModalCommentSegue" {
                if let cell = sender as? MessageBoardTableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    detailVC.postController = self.postController
                    detailVC.post = self.localPosts[indexPath.row]
                }
            }
        }
    }
}

extension MessageBoardTableViewController: CreateMessageBoardViewControllerDelegate {
    func postButtonWasTapped() {
        postController?.fetchPosts { (error) in
            if let _ = error {
                print("Error")
            } else {
                self.localPosts = self.postController?.parsePosts(lat: self.usersLat, long: self.usersLong) ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MessageBoardTableViewController: MessageBoardTableViewCellDelegate {
    func commentButtonWasPressed(_ messageBoardCell: MessageBoardTableViewCell) {
        self.performSegue(withIdentifier: "ModalCommentSegue", sender: messageBoardCell)
    }
}
