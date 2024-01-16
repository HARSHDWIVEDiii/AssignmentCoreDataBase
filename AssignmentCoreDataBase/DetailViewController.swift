//
//  DetailViewController.swift
//  AssignmentCoreDataBase
//
//  Created by Mac on 16/01/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    
    var userDetailsContainer : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        
    }
    func bindData(){
        self.idLabel.text = userDetailsContainer?.id.description.codingKey.stringValue
        self.nameLabel.text = userDetailsContainer?.name.description.codingKey.stringValue
        self.userNameLabel.text = userDetailsContainer?.username.description.codingKey.stringValue
        self.emailLabel.text = userDetailsContainer?.email.description.codingKey.stringValue
    }
    
}
