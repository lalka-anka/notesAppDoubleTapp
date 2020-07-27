//
//  DisplayNoteCreateController.swift
//  pagesApp
//
//  Created by lalka_anka on 07.07.2020.
//  Copyright © 2020 lalka-anka. All rights reserved.
//

import UIKit

class DisplayNoteCreateController: UIViewController, UITextViewDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        contentTextView.text = "content"
        contentTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.textColor == UIColor.lightGray {
            contentTextView.text = nil
            contentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text.isEmpty {
            contentTextView.text = "content"
            contentTextView.textColor = UIColor.lightGray
        }
    }
    
    var note: Note?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case "save" where note == nil:
            print("save bar button item tapped")
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.creationTime = Date()
            CoreDataHelper.saveNote()
            checkEmptyFields(note: note, for: segue)
            
            case "save" where note != nil:
            print("save bar button item tapped")
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.creationTime = note?.creationTime
            CoreDataHelper.saveNote()
            checkEmptyFields(note: note!, for: segue)

        case "cancel":
            print("cancel bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if note == nil {
            titleTextField.text = ""
            titleTextField.placeholder = "title"
        }
        else {
            titleTextField.text = note?.title
            contentTextView.text = note?.content
            contentTextView.textColor = UIColor.black
        }
    }
    
    func checkEmptyFields(note: Note, for segue: UIStoryboardSegue) {
        if note.title == "" || note.content == "" || contentTextView.textColor == UIColor.lightGray {
            let alertController = UIAlertController(title: "Error", message: "Enter the title or content", preferredStyle: .alert)
            present(alertController, animated: true, completion: nil)
            _ = segue.destination as! NotesController
            CoreDataHelper.delete(note: note)
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
}

