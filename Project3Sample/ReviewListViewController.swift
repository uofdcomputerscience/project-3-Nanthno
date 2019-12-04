//
//  ReviewListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController {
    
    
    @IBOutlet weak var reviewTable: UITableView!
    let reviewService = ReviewService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewService.fetchReviews {
            DispatchQueue.main.async {
                self.reviewTable.reloadData()
            }
        }
        
        reviewTable.dataSource = self
        reviewTable.delegate = self
        
    }
    
    @IBAction func refreshReviewsTapped(_ sender: Any) {
        reviewService.fetchReviews {
            DispatchQueue.main.async {
                self.reviewTable.reloadData()
                print("refresh")
            }
        }
    }
}
extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (reviewService.reviews.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = reviewService.reviews[indexPath.item]
        
        let cell = reviewTable.dequeueReusableCell(withIdentifier: "ReviewCell")!
        if let reviewCell = cell as? ReviewCell {
            reviewCell.title.text = review.title
            reviewCell.reviewText.text = review.body
            reviewCell.author.text = review.reviewer
            return reviewCell
        }
        
        return cell
    }
}

extension ReviewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rev = reviewService.reviews[indexPath.item]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
        vc.review = rev
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
