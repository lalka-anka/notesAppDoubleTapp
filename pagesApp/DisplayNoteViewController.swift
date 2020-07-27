//
//  DisplayNoteViewController.swift
//  pagesApp
//
//  Created by lalka_anka on 07.07.2020.
//  Copyright © 2020 lalka-anka. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case "edit":
            print("edit bar button item tapped")
            let destination = segue.destination as! DisplayNoteCreateController
            destination.note = note

        case "cancel":
            print("cancel bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var creationTimeTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let note = note {
            titleTextField.text = note.title
            titleTextField.isEnabled = false
            contentTextView.text = note.content
            contentTextView.isEditable = false
            creationTimeTextField.text = note.creationTime?.convertToString()
            creationTimeTextField.isEnabled = false
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
}
