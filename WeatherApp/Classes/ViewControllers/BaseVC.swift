//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
   
    var ref = UIRefreshControl()
    var stateView:SDStateView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        //Handling touch on the screen to hide the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTouch))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        //
        self.ref.addTarget(self, action: #selector(getRefreshing), for: .valueChanged)
    }
    
    
    //Create a new state view
    func createStateView(view: UIView? = nil){
        guard let sourceView = view ?? self.view
            else {return}
        if let stateView = self.stateView {
            stateView.removeFromSuperview()
        }
        self.stateView = SDStateView(frame: sourceView.frame)
        self.stateView?.center = sourceView.center
        self.stateView?.setDataAvailable()
        self.stateView?.sendBehind(view: sourceView)
    }

    
    func setupViews(){
        
    }
    
    
    @objc func getRefreshing(){
        
    }
    
    
    @objc func onTouch() {
        self.view.endEditing(true)
    }
    
}
