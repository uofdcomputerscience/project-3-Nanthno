//
//  BookDetailViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    let bookService = BookService.shared
    let reviewService = ReviewService.shared
    
    var book : Book?
    var reviews : [Review]?
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publicationYear: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var imageNotFoundLabel: UILabel!
    
    @IBOutlet weak var reviewTable: UITableView!
    
    override func viewDidLoad() {
        reviewTable.dataSource = self
        reviewTable.delegate = self
        if let bk = book {
            
            reviews = reviewService.getReviews(bookId: bk.id!)
            
            bookTitle.text = bk.title
            author.text = bk.author
            publicationYear.text = bk.published
            bookService.image(for: bk, completion: {_, bookImage in
                if let img = bookImage {
                    DispatchQueue.main.async {
                        self.imageNotFoundLabel.isHidden = true
                    }
                    self.coverImage.image = img
                }
                else {
                    DispatchQueue.main.async {
                        self.imageNotFoundLabel.isHidden = false
                    }
                }
            })
        }
    }
}

extension BookDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = reviews![indexPath.item]
        let reviewCell = reviewTable.dequeueReusableCell(withIdentifier: "BookReviewCell")!
        if let cell = reviewCell as? BookReviewCell {
            cell.reviewTitle.text = review.title
            cell.reviewBody.text = review.body
            cell.reviewer.text = review.reviewer
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, d, yyyy"
            if let d = review.date {
                cell.datePosted.text = formatter.string(from: d)
            }
            else {
                cell.datePosted.text = "[unknown post date]"
            }
            
            return cell
        }
        return reviewCell
    }
    
    
}
extension BookDetailViewController: UITableViewDelegate {
    //
}
