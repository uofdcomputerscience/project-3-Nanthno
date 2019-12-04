//
//  BookListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

import UIKit

class BookListViewController: UIViewController {
    
    @IBOutlet weak var bookTable: UITableView!
    
    let bookService = BookService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookService.fetchBooks {
            DispatchQueue.main.async {
                self.bookTable.reloadData()
            }
        }
        
        bookTable.dataSource = self
        bookTable.delegate = self
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (bookService.books.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = bookService.books[indexPath.item]
        let title = book.title
        
        let cell = bookTable.dequeueReusableCell(withIdentifier: "BookCell")!
        if let bookCell = cell as? BookCell {
            bookCell.bookTitle.text = title
            return bookCell
        }
        
        return cell
    }


}
extension BookListViewController: UITableViewDelegate {
    
}
