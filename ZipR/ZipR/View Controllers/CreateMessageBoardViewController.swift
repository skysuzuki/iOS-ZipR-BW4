//
//  CreateMessageBoardViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import TagListView

protocol CreateMessageBoardViewControllerDelegate {
    func postButtonWasTapped()
}

class CreateMessageBoardViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var tagsView: TagListView!

    var postController: PostController?
    var delegate: CreateMessageBoardViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextView()
    }

    private func setUpTextView() {
        descriptionTextView.delegate = self
        descriptionTextView.text = "Text Post"
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 10.0
        descriptionTextView.layer.borderWidth = 1.0
    }

    private func postMessageBoard() {
        guard let titleString = titleTextField.text,
            !titleString.isEmpty,
            let descriptionString = descriptionTextView.text,
            !descriptionString.isEmpty,
            let postController = postController,
            let user = postController.user,
            let lat = user.latitude,
            let long = user.longitude else { return }
        let date = Date()
        let dateString = String(date.timeIntervalSince1970)

        let tags = tagsView.tagViews.map { $0.titleLabel?.text ?? "" }
        
        postController.createPost(author: user.name, title: titleString, description: descriptionString, tag: tags, lat: lat, long: long, date: dateString)
        delegate?.postButtonWasTapped()
    }

    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
        postMessageBoard()
        self.dismiss(animated: true, completion: nil)
    }


     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tagVC = segue.destination as? PostTagTableViewController {
            tagVC.delegate = self
        }
     }

}

extension CreateMessageBoardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Text Post"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension CreateMessageBoardViewController: PostTagTableViewControllerDelegate {
    func tagsWerePicked(_ tags: [String]) {
        tagsView.addTags(tags)
    }
}
