//
//  CustomAlert.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import Foundation
import UIKit

class CustomAlert: UIView, Modal {
    var backgroundView = UIView()
    var dialogView: UIView? //= UIView()
    
    
    convenience init(withView view: UIView) {
        self.init(frame: UIScreen.main.bounds)
        initialize(withView: view)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(withView view:UIView){
        dialogView = view
        dialogView!.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        dialogView!.center = CGPoint(x: center.x, y: frame.height + dialogView!.frame.height/2)
        let window = UIApplication.shared.keyWindow
        let screenSize = UIScreen.main.bounds.size
        let viewSize = dialogView?.frame.size
        let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        let width = viewSize!.width > screenSize.width - 40 ? screenSize.width - 40 : viewSize?.width
        let ht = viewSize!.height > screenSize.height - 40 ? screenSize.height - 40 - (topPadding! + bottomPadding!) : viewSize?.height
        dialogView!.frame.size = CGSize(width: width!, height: ht!)

        addSubview(dialogView!)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
}
