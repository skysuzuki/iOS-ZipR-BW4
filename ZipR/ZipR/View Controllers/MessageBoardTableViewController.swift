//
//  MessageBoardTableViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MessageBoardTableViewController: UITableViewController {

    let postController = PostController()

    override func viewDidLoad() {
        super.viewDidLoad()

        postController.fetchPosts { (error) in
            if let _ = error {
                print("Error")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postController.posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBoardCell", for: indexPath) as? MessageBoardTableViewCell else {
            return UITableViewCell()
        }

        cell.post = postController.posts[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let cell = cell as? MessageBoardTableViewCell else { return }

        cell.setCollectionViewDataSourceDelegte(dataSourceDelegate: self, forRow: indexPath.row)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        case "ModalCreateMessageBoardSegue":
            if let detailVC = segue.destination as? CreateMessageBoardViewController {
                detailVC.postController = self.postController
                detailVC.delegate = self
            }
            return
        case "ModalCommentSegue", "ModalDetailPostSegue" :
            if let detailVC = segue.destination as? DetailPostViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.postController = self.postController
                detailVC.post = self.postController.posts[indexPath.row]
            }
            return
        default:
            return
        }
    }


}

extension MessageBoardTableViewController: CreateMessageBoardViewControllerDelegate {
    func postButtonWasTapped() {
        postController.fetchPosts { (error) in
            if let _ = error {
                print("Error")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MessageBoardTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postController.posts[collectionView.tag].tag?.count ?? 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }

        print(collectionView.tag)
        print(postController.posts[collectionView.tag].tag?[indexPath.item] ?? "No Tag")
        cell.tagLabel.text = postController.posts[collectionView.tag].tag?[indexPath.item] ?? "No Tag"
        return cell
    }

}
