//
//  ViewController.swift
//  AssignmentCoreDataBase
//
//  Created by Mac on 16/01/24.
//


import UIKit

class ViewController: UIViewController {
    var usersArray : [User] = []
    var users : [User] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromApi()
        
        registerXibWithCollectionView()
        initilizeCollectionView()
    }
    
    
    
    
    @IBAction func switchButtonChangeData(_ sender: UISwitch) {
        if sender.isOn == true{
            self.users = DatabaseManager.shared.retrivedDataFromCoreData()!
            print("users data Db\(users)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        else {
            self.users = self.usersArray
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    func fetchDataIntoDatabaseFromApi(){
        for eachUser in self.usersArray{
            DatabaseManager.shared.insertDataFromApiToCoreData(user: eachUser)
        }
        self.users = DatabaseManager.shared.retrivedDataFromCoreData()!
        print(users)
    }
    
    
    
    
    
    func registerXibWithCollectionView(){
        let uinib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(uinib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    func initilizeCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchDataFromApi(){
        var url = URL(string: "https://jsonplaceholder.typicode.com/users")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        var urlSesson = URLSession(configuration: .default)
        var dataTask = urlSesson.dataTask(with: urlRequest) { data, response , error in
            print(data)
            print(response)
            print(error)
            let response = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            print(response)
            for UserResponse in response{
                let userDictonary = UserResponse as! [String:Any]
                let userId = userDictonary["id"] as! Int
                let userName = userDictonary["name"] as! String
                let usersName = userDictonary["username"] as! String
                let userEmail = userDictonary["email"] as! String
        
                let addressDictonary = userDictonary["address"] as! [String:Any]
                let userStreet = addressDictonary["street"] as! String
                let userSuite = addressDictonary["suite"] as! String
                let userCity = addressDictonary["city"] as! String
                let userZipCode = addressDictonary["zipcode"] as! String
                
                let userGeo = addressDictonary["geo"] as! [String:Any]
                let userLat = userGeo["lat"] as! String
                let userLng = userGeo["lng"] as! String
                
                let userCompany = userDictonary["company"] as! [String:Any]
                let companyName = userCompany["name"] as! String
                let companyAddressDictonary = userCompany["catchPhrase"] as! String
                let companyBs = userCompany["catchPhrase"] as! String
                
                let newUser = User(
                id: userId,
                name: userName,
                username: "",
                email: userEmail,
                address: Address(
                    street: userStreet,
                    suite: userSuite,
                    city: userCity,
                    zipcode: userZipCode,
                    geo: Geo(lat: userLat, lng: userLng)
                ),
                phone: "",
                website: "",
                company: Company(name: companyName, catchPhrase: "", bs: "")
            )
                self.fetchDataIntoDatabaseFromApi()
            self.usersArray.append(newUser)
                
                }
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
            }
        dataTask.resume()
        }
    }
    
extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.userDetailsContainer = usersArray[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
                   return UICollectionViewCell()
               }

               let user = usersArray[indexPath.item]
        cell.nameLabel.text = user.name
        cell.emailLabel.text = user.email

               return cell
           }
    
}
extension ViewController :  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenTheCell : CGFloat = (flowlayout.minimumInteritemSpacing ?? 0.0) + (flowlayout.sectionInset.left ?? 0.0) + (flowlayout.sectionInset.right ?? 0.0)
        
        let size = (collectionView.frame.width - spaceBetweenTheCell) / 2
        return CGSize(width: size, height: size)
    }
}
