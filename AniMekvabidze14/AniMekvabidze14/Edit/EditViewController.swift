//
//  EditViewController.swift
//  AniMekvabidze14
//
//  Created by Mac User on 5/18/21.
//

import UIKit

protocol  EditTextDelegate {
    
    func updateText(updatedTitle: String, updatedBody: String)
}


class EditViewController: UIViewController, UITextViewDelegate {
    
   
    @IBAction func onDoneButton(_ sender: UIBarButtonItem) {
        self.bodyTextView.resignFirstResponder()
        
        self.DoneButton.isEnabled = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    var editTextDelegate: EditTextDelegate?
    
    var textBody: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bodyTextView.delegate = self
        self.bodyTextView.text = textBody
        self.bodyTextView.becomeFirstResponder()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.editTextDelegate != nil {
            
            self.editTextDelegate?.updateText(updatedTitle: getTextTitle(), updatedBody: self.bodyTextView.text)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.DoneButton.isEnabled = true

    }
    
    
    func getTextTitle() -> String{
        let components = self.bodyTextView.text.components(separatedBy: "\n")
        for component in components{
            if component.trimmingCharacters(in: CharacterSet.whitespaces).count > 0 {
                return component
            }
        }
        return self.navigationItem.title ?? ""
    }


}
