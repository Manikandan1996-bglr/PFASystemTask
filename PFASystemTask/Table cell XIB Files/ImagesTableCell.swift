//
//  ImagesTableCell.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import UIKit

class ImagesTableCell: UITableViewCell {
    
    @IBOutlet weak var bannerCV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCV.delegate = self
        bannerCV.dataSource = self
        bannerCV.register(UINib(nibName: "TopImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TopImageCollectionCell")
    }
}

extension ImagesTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImageCollectionCell", for: indexPath) as! TopImageCollectionCell
        print(bannerImage)
            self.downloadImageFromUrl(imageUrl: bannerImage[indexPath.row]) { (image) in
                DispatchQueue.main.async {
            cell.bannerImage.image = image
                }
            }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize.init(width: frame.width - 30, height: collectionView.frame.height)
    }
}
