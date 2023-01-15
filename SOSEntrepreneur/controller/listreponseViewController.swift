//
//  listreponseViewController.swift
//  doctor
//
//  Created by User on 03.01.2022.
//

import UIKit
import Alamofire
class listreponseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
//var
    var usertable : User?
    var userviewmodelm = userVM()
    private let refreshControl = UIRefreshControl()
    var reponseviewmodel = reponseVM()
    var question : Question?
    var filteredData = [Reponse]()
    var listuser = [User]()
    //outlet
    @IBOutlet weak var listrepondre: UITableView!
    
    //list
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return filteredData.count//6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           tableView.backgroundColor = UIColor(hex: 0xE6FAF0)
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let label = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
           let imageView = contentView?.viewWithTag(2) as! UIImageView
           
           imageView.layer.masksToBounds = false
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.frame.height/2
           imageView.clipsToBounds = true
         
           text.text = filteredData[indexPath.row].description
           
           userviewmodelm.getOwnerToy(OwnerId: (filteredData[indexPath.row].idUser)! , successHandler: {anomalyList in
               self.usertable = anomalyList
               print("alamofire :")
               print(self.usertable!)
               label.text = self.usertable?.nom
               var path = String("http://localhost:3000/"+(self.usertable?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
               imageView.af.setImage(withURL: url)
                   }, errorHandler: {
                       print("errorororoor")
                   })
           
           
           
           return cell!
           
       }
       
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
           if segue.identifier == "pass"{
               let destination = segue.destination as! newreponseViewController
               destination.userviewmodelm = userviewmodelm
               destination.question = question
           }
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
           return
       }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        reponseviewmodel.getOwnerToy(OwnerId: (question?._id)!,successHandler: {anomalyList in
                    self.filteredData = anomalyList
            self.filteredData.reverse()
           
            self.listrepondre.reloadData()
                }, errorHandler: {
                    print("errorororoor")
                })
           
        
  
    
       
        if #available(iOS 10.0, *) {
            listrepondre.refreshControl = refreshControl
        } else {
            listrepondre.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
     
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...")
        
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        reponseviewmodel.getOwnerToy(OwnerId: (question?._id)!,successHandler: {anomalyList in
                    self.filteredData = anomalyList
            self.filteredData.reverse()
           
            self.listrepondre.reloadData()
            self.refreshControl.endRefreshing()
                }, errorHandler: {
                    print("errorororoor")
                })
      
               
                
            
        
    }
  

    //func
    
    @IBAction func repondre(_ sender: Any) {
        performSegue(withIdentifier: "pass", sender: sender)
    }
    
}
