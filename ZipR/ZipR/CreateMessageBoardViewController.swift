//
//  CreateMessageBoardViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol CreateMessageBoardViewControllerDelegate {
    func postButtonWasTapped()
}

class CreateMessageBoardViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!

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


    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

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

    /*
     // can fix the double capital letters
     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     let currentText: String = textView.text
     let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

     if updatedText.isEmpty {
     textView.text = "Text Post"
     textView.textColor = UIColor.lightGray
     textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
     } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
     textView.textColor = UIColor.black
     textView.text = text
     } else { return true }

     return false
     }



     func textViewDidChangeSelection(_ textView: UITextView) {
     if self.view.window != nil {
     if textView.textColor == UIColor.lightGray {
     textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
     }
     }
     }
     */
}
