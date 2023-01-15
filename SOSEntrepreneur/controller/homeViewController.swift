//
//  homeViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
class homeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource , UISearchBarDelegate{
    var userviewmodelm = userVM()
    var questionviewmodel = questionVM()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var profilpicture: UIImageView!
    var movie : Question?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var data = [Question]()
    var filteredData = [Question]()
    var usertable : User?
    
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
           label.text = filteredData[indexPath.row].subject
           text.text = filteredData[indexPath.row].description
           userviewmodelm.getOwnerToy(OwnerId: (filteredData[indexPath.row].idClient)! , successHandler: {anomalyList in
               self.usertable = anomalyList
               print("alamofire :")
               print(self.usertable!)
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
           
           if segue.identifier == "newQuestion"{
               let destination = segue.destination as! newquestionViewController
               destination.userviewmodelm = userviewmodelm
           }else       if segue.identifier == "mSegue"{
               let destination = segue.destination as! quesViewController
               destination.userviewmodelm = userviewmodelm
               destination.question = movie
           }
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            movie = filteredData[indexPath.row]
           performSegue(withIdentifier: "mSegue", sender: nil)
           
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: Question) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.subject!.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profilpicture.layer.borderWidth = 1
        profilpicture.layer.masksToBounds = false
        profilpicture.layer.borderColor = UIColor.black.cgColor
        profilpicture.layer.cornerRadius = profilpicture.frame.height/2
        profilpicture.clipsToBounds = true
        // Do any additional setup after loading the view.
     sleep(1)
        print("///////////////////////")
          print(userviewmodelm.tokenString!)
               var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                     path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
        profilpicture.af.setImage(withURL: url)
          
        questionviewmodel.getOwnerToy(successHandler: {anomalyList in
                    self.data = anomalyList
            self.filteredData = self.data
            self.filteredData.reverse()
            self.tableView.reloadData()
                }, errorHandler: {
                    print("errorororoor")
                })
           
  
        //
        
       
        //
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
        filteredData.removeAll()
        data.removeAll()
        tableView.reloadData()
        questionviewmodel.getOwnerToy(successHandler: {anomalyList in
                    self.data = anomalyList
            self.filteredData = self.data
            self.filteredData.reverse()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
                }, errorHandler: {
                    print("errorororoor")
                })
              
                
            
        
    }
  

   
    
    @IBAction func addquestion(_ sender: Any) {
        var x = Int((self.userviewmodelm.userToken?.money)!)
        
        if(x!<10){
            
            prompt(title: "warning", message: "Your Sold is empty !!")
            
        
        }else
        {
        }
        performSegue(withIdentifier: "newQuestion", sender: sender)
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
    
 
}
