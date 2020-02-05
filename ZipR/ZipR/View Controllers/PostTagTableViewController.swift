//
//  PostTagTableViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol PostTagTableViewControllerDelegate {
    func tagsWerePicked(_ tags: [String])
}

class PostTagTableViewController: UITableViewController {

    var delegate: PostTagTableViewControllerDelegate?
    var tags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func toggleTag(_ tagString: String) -> Bool {
        if tags.contains(tagString) {
            return true
        }
        return false
    }

    @IBAction private func doneButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.tagsWerePicked(tags)
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tag.allCases.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)

        let tagString = Tag.allCases[indexPath.row].rawValue
        cell.textLabel?.text = tagString.capitalized
        cell.imageView?.image = toggleTag(tagString) ? UIImage(systemName: "checkmark") : nil

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let tagString = Tag.allCases[indexPath.row].rawValue
        if toggleTag(tagString) {
            if let index = tags.firstIndex(of: tagString) {
                tags.remove(at: index)
            }
        } else {
            tags.append(tagString)
        }
        tableView.reloadData()
    }


}
