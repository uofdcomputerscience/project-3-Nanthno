//
//  BookInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookInputViewController: UIViewController {
    
    let bookService = BookService.shared
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var yearPublishedField: UITextField!
    @IBOutlet weak var coverUrlField: UITextField!
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var fillOutAllFieldsLabel: UILabel!
    @IBOutlet weak var enterValidUrlLabel: UILabel!
    @IBOutlet weak var bookPublishedLabel: UILabel!
    
    
    @IBAction func coverUrlFinishedEntering(_ sender: Any) {
        let urlString = coverUrlField.text
        bookService.image(for: urlString ?? "", completion: {image in
            if let img = image {
                self.coverImage.image = img
            }
        })
    }
    
    @IBAction func publishBookTapped(_ sender: Any) {
        let bookTitle = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let author = authorField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let published = yearPublishedField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let coverUrl = coverUrlField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (bookTitle == "" || author == "" || published == "" || coverUrl == "") {
            fillOutAllFieldsLabel.isHidden = false
        }
        else if URL(string: coverUrl!) == nil {
            enterValidUrlLabel.isHidden = false
        }
        else {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
            titleField.text = ""
            authorField.text = ""
            yearPublishedField.text = ""
            coverUrlField.text = ""
            displayBookPublished()
            
            
            let book = Book(id: nil, title: bookTitle!, author: author!, published: published!, imageURLString: coverUrl)
            //bookService.createBook(book: book, completion: {
            //    self.bookService.fetchBooks {
                    //
             //   }
            //})
        }
    }
    func displayBookPublished() {
        
        self.bookPublishedLabel.alpha = 1
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 4, animations: {
                self.bookPublishedLabel.alpha = 0.0
            }, completion: { (_) in
                //
            })
        }
    }
}
