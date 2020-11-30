//
//  ReponseVC.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import UIKit

var responseData: [[String: Any]] = []
var bannerImage:[String] = []
class ReponseVC: UIViewController {

    @IBOutlet weak var responseTV: UITableView!
    @IBOutlet var popup: PopupView!
    var alert: CustomAlert!
    var popupView: PopupView!
    override func viewDidLoad() {
        super.viewDidLoad()
        responseTV.register(UINib.init(nibName: "ImagesTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ImagesTableCell")
        responseTV.register(UINib.init(nibName: "ContentTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ContentTableCell")
        
    }
    
    func getResponseData() {
        getResponse { (result) in
            switch result {
            case .success(let response):
                for data in response["articles"] as! [[String: Any]] {
                    responseData.append(data)
                }
                print(response)
            case .failure(let error):
                print(error)
            }
            print(responseData)
            for details in responseData {
                if details["urlToImage"] as? String != nil {
                    bannerImage.append(details["urlToImage"] as! String)
                }
            }
            DispatchQueue.main.async {
                self.responseTV.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.responseTV.reloadRows(at: [indexPath], with: UITableView.RowAnimation.top)
            }
        }
    }
}

extension ReponseVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableCell") as! ImagesTableCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableCell") as! ContentTableCell
            cell.selectionStyle = .none
            cell.title.text = responseData[indexPath.row]["title"] as? String
            cell.descriptionLbl.text = responseData[indexPath.row]["description"] as? String
            cell.author.text = responseData[indexPath.row]["author"] as? String
            if responseData[indexPath.row]["urlToImage"] as? String != nil {
                downloadImageFromUrl(imageUrl: (responseData[indexPath.row]["urlToImage"] as? String)!) { (image) in
                    DispatchQueue.main.async {
                        cell.authorImage.image = image
                    }
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 150
        } else {
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert =  CustomAlert(withView: popup)
        self.popup.titleLbl.text = "Title \(responseData[indexPath.row]["title"] as? String ?? "")"
            self.popup.desLbl.text = responseData[indexPath.row]["description"] as? String
        self.popup.authorLbl.text = "Author \(responseData[indexPath.row]["author"] as? String ?? "")"
            self.downloadImageFromUrl(imageUrl: responseData[indexPath.row]["urlToImage"] as? String ?? "https://cdn.yenicaggazetesi.com.tr/news/320800.jpg") { (image) in
                DispatchQueue.main.async {
                    self.popup.authorImage.image = image
                }
            }
        alert.show(animated: true)
    }
}
