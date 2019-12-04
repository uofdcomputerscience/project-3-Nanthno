//
//  ReviewDetailViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    
    let bookService = BookService.shared
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviewer: UILabel!
    @IBOutlet weak var dateOfReview: UILabel!
    @IBOutlet weak var body: UITextView!
    
    var review : Review?
    var book : Book?
    
    override func viewDidLoad() {
        if let rev = review {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, d, yyyy"
            if let d = rev.date {
                dateOfReview.text = formatter.string(from: d)
            }
            else {
                dateOfReview.text = "[unknown post date]"
            }
            book = bookService.getBook(withId: rev.bookId)
            bookTitle.text = book?.title
            reviewTitle.text = rev.title
            reviewer.text = rev.reviewer
            body.text = rev.body
        }
    }
    
    @IBAction func goToBookButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        vc.book = book
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
