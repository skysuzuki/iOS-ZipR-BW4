//
//  PostTagTableViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol PostTagTableViewControllerDelegate {
    func tagsWerePicked()
}

class PostTagTableViewController: UITableViewController {

    var delegate: PostTagTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction private func doneButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.tagsWerePicked()
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Tag.allCases.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)

        cell.textLabel?.text = Tag.allCases[indexPath.row].rawValue.capitalized
        //cell.imageView?.image = UIImage(systemName: "checkmark")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)

        //cell.imageView?.image = UIImage(systemName: "checkmark")

    }


}
