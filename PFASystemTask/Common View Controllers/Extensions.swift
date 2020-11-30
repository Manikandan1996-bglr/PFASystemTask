//
//  Extensions.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import Foundation
import UIKit

extension UIViewController {
    func downloadImageFromUrl(imageUrl: String, completion: @escaping (_ success: UIImage) -> Void) {
        let url = URL(string: imageUrl)
        if url != nil {
            let task = URLSession.shared.dataTask(with: url!) {
                data, response, error in
                guard let data = data, error == nil else { return }
                completion(UIImage(data: data)!)
            }
            task.resume()
        } else {
            let imageurl = URL(string: "https://static.coindesk.com/wp-content/uploads/2020/11/GettyImages-1284947587-1200x628.jpg")
            let task = URLSession.shared.dataTask(with: imageurl!) {
                data, response, error in
                guard let data = data, error == nil else { return }
                completion(UIImage(data: data)!)
            }
            task.resume()
        }
    }
}

extension UITableViewCell {
    func downloadImageFromUrl(imageUrl: String, completion: @escaping (_ success: UIImage) -> Void) {
        let url = URL(string: imageUrl)
        if url != nil {
            let task = URLSession.shared.dataTask(with: url!) {
                data, response, error in
                guard let data = data, error == nil else { return }
                completion(UIImage(data: data)!)
            }
            task.resume()
        } else {
            let imageurl = URL(string: "https://static.coindesk.com/wp-content/uploads/2020/11/GettyImages-1284947587-1200x628.jpg")
            let task = URLSession.shared.dataTask(with: imageurl!) {
                data, response, error in
                guard let data = data, error == nil else { return }
                completion(UIImage(data: data)!)
            }
            task.resume()
        }
    }
}

extension UIApplication{
    class func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        return presentViewController
    }
}
