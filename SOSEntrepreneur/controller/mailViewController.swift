//
//  mailViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
class mailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

   //var
    var usertable = [User]()
    var userviewmodelm = userVM()
    var messagerieviewmodel = messagerieVM()
    var movie : Messagerie?
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var profileimage: UIImageView!
    
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var data = [Messagerie]()
    var filteredData = [Messagerie]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return filteredData.count //6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           tableView.backgroundColor = UIColor(hex: 0xE6FAF0)
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let subject = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
           let imageView = contentView?.viewWithTag(2) as! UIImageView
           let from = contentView?.viewWithTag(4) as! UILabel
           imageView.layer.masksToBounds = false
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.frame.height/2
           imageView.clipsToBounds = true
           subject.text = "From: "+filteredData[indexPath.row].from!
           from.text = "Subject: "+filteredData[indexPath.row].object!
           text.text = filteredData[indexPath.row].message
         
           
           userviewmodelm.getOwnermail(OwnerId: (filteredData[indexPath.row].from)! , successHandler: {anomalyList in
               self.usertable = anomalyList
               print("alamofire :")
              
               var path = String("http://localhost:3000/"+(self.usertable[0].imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
               imageView.af.setImage(withURL: url)
                   }, errorHandler: {
                       print("errorororoor")
                   })
           
           
           return cell!
           
       }
       
     
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
            movie = filteredData[indexPath.row]
           performSegue(withIdentifier: "open", sender: movie)
           
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: Messagerie) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.from!.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profileimage.layer.borderWidth = 1
        profileimage.layer.masksToBounds = false
        profileimage.layer.borderColor = UIColor.black.cgColor
        profileimage.layer.cornerRadius = profileimage.frame.height/2
        profileimage.clipsToBounds = true
        // Do any additional setup after loading the view.
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
               let url = URL(string: path)!
               print(url)
        profileimage.af.setImage(withURL: url)
        
        messagerieviewmodel.getOwnerToy(successHandler: {anomalyList in
                  self.data = anomalyList
            self.data.forEach{ msg in if(msg.from == self.userviewmodelm.userToken?.email || msg.to == self.userviewmodelm.userToken?.email ){self.filteredData.append(msg)} }
            self.data = self.filteredData
            self.filteredData.reverse()
            self.data.reverse()
          self.tableView.reloadData()
              }, errorHandler: {
                  print("errorororoor")
              })
         
        
      
 
   
     
  
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
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
        self.data.removeAll()
        self.filteredData.removeAll()
        
        messagerieviewmodel.getOwnerToy(successHandler: {anomalyList in
                  self.data = anomalyList
            self.data.forEach{ msg in if(msg.from == self.userviewmodelm.userToken?.email || msg.to == self.userviewmodelm.userToken?.email ){self.filteredData.append(msg)} }
            self.data = self.filteredData
            self.filteredData.reverse()
            self.data.reverse()
          self.tableView.reloadData()
            self.refreshControl.endRefreshing()
              }, errorHandler: {
                  print("errorororoor")
              })
         
      
   
       
                
                
            
        
    }
  

   //action
    
  
    
    @IBAction func newMessage(_ sender: Any) {
        performSegue(withIdentifier: "newMessege", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newMessege"{
            let destination = segue.destination as! newmailViewController
            destination.userviewmodelm = userviewmodelm
            
        }else  if segue.identifier == "open"{
            let destination = segue.destination as! emailcheckViewController
            destination.userviewmodelm = userviewmodelm
            destination.mail = movie
        }
        
    }
}
