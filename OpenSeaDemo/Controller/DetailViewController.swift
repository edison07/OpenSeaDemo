//
//  DetailViewController.swift
//  OpenSeaDemo
//
//  Created by Funday on 2020/4/22.
//  Copyright © 2020 Edison. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    var data: DataModelAssets?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let data = data else { return }
        if let url = data.image_url, let imageURL = URL(string: url) {
            if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                    let newHeight = (image.size.height * imageView.frame.width) / image.size.width
                    height.constant = newHeight
                    imageView.layoutIfNeeded()
                    imageView.sd_setImage(with: imageURL, completed: nil)
                }
            }

        nameLabel.text = data.name
        descriptionTextView.text = data.description
        title = data.collection.name
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebViewController
        vc.url = data?.permalink
    }

}
