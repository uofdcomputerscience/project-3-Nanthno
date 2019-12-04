//
//  ReviewInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewInputViewController: UIViewController {
    
    let reviewService = ReviewService.shared
    
    var book : Book?

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var reviewTitleField: UITextView!
    @IBOutlet weak var bodyField: UITextView!
    
    @IBOutlet weak var fillOutAllFieldsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillOutAllFieldsLabel.isHidden = true
        reviewTitleField.text = ""
        bodyField.text = ""
    }
    
    @IBAction func postReviewTapped(_ sender: Any) {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let reviewTitle = reviewTitleField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let body = bodyField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (name == "" || reviewTitle == "" || body == "") {
            fillOutAllFieldsLabel.isHidden = false
        }
        else {
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
            let review = Review(id: nil, bookId: (book?.id)!, date: Date(), reviewer: nameField.text!, title: reviewTitleField.text, body: bodyField.text)
            reviewService.createReview(review: review, completion: {
                self.reviewService.fetchReviews {
                    //
                }
            })
        }
    }
}
