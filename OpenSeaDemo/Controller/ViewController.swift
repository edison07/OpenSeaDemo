//
//  ViewController.swift
//  OpenSeaDemo
//
//  Created by Funday on 2020/4/21.
//  Copyright © 2020 Edison. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [DataModelAssets] = []
    
    private var isDataLoading = false
    private var indicator = UIActivityIndicatorView(style: .medium)
    private var offset = 0
    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getData()
    }

    private func getData() {
        API.download(offset: String(offset)) { [weak self](data) in
            guard let self = self else { return }
            for i in data.assets {
                self.data.append(i)
            }
            self.collectionView.reloadData()
            self.indicator.stopAnimating()
            self.isDataLoading = false
        }
    }
    
    private func getMoreData() {
        offset += 20
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.data = data[index]
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ListCollectionViewCell.self, for: indexPath)

        if let url = data[indexPath.row].image_url, let imageURL = URL(string: url) {

            cell.imageView.sd_setImage(with: imageURL, completed: nil)
            
        }
        cell.nameLabel.text = data[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "detail", sender: nil)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 30) / 2, height: 200)
    }

}

//MARK: ScrollViewDelegate
//滑到最下面cell自動加載下一頁
extension ViewController {
    //滑到底部時開始下載下一頁資料
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //底部的座標
        if ((collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height) {
            //如果沒再撈資料的話才載,避免重複下載
            if !isDataLoading {
                isDataLoading = true
                self.view.addSubview(indicator)
                indicator.hidesWhenStopped = true
                indicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY - 50)
                indicator.startAnimating()
                getMoreData()
            }
        }
    }
}
