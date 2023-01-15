//
//  userviewmodel.swift
//  doctor
//
//  Created by achref on 19/11/2021.
//

import Foundation
import Alamofire
class reponseVM {
  
    var AllReponse = [Reponse]()
    func getOwnerToy(OwnerId:String, successHandler: @escaping (_ anomalyList: [Reponse]) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/getreponsesid/"+OwnerId
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of: [Reponse].self, decoder: JSONDecoder()) { apiResponse in
                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
                
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                    successHandler(try! apiResponse.result.get())

                    case 500:
                    errorHandler()
               
                default:
                  errorHandler()
                    
                }
                
            }
            
        }
    func getallreponses(idQuestion:String)  {
       
        
        let jsonUrlString = "http://localhost:3000/getreponsesid/"+idQuestion
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.AllReponse.removeAll()

                    let reponses = try JSONDecoder().decode([Reponse].self, from: data)
                 
                    reponses.forEach { user in self.AllReponse.append(user) }
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
    }
    
    
   
    func createreponse(description:String,idUser:String,idQuestion:String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createreponse")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "description="+description+"&"+"idUser="+idUser+"&"+"idQuestion="+idQuestion+"&"
          
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")

                if(responseString?.contains("true"))!{
                    print("status = true")
                }
                else{
                    print("Status = false")
                }
            }

            task.resume()
        }
    
    
     func updatereponse(){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updatereponse/61997b27612d99bb5c619907")!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString =
        "description=update&" +
        "datecreation=2020-12-12T08:00:00.000Z&"
             request.httpBody = postString.data(using: .utf8)
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 guard let data = data, error == nil else {                                                 // check for fundamental networking error
                     print("error=\(String(describing: error?.localizedDescription))")
                     return
                 }

                 if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                     print("statusCode should be 200, but is \(httpStatus.statusCode)")
                     print("response = \(String(describing: response))")
                 }

                 let responseString = String(data: data, encoding: .utf8)
                 print("responseString = \(String(describing: responseString))")

                 if(responseString?.contains("true"))!{
                     print("status = true")
                 }
                 else{
                     print("Status = false")
                 }
             }

             task.resume()
         }
    
    func deletereponse(){
        var request = URLRequest(url: URL(string: "http://localhost:3000/deletereponse/61997b27612d99bb5c619907")!)
            request.httpMethod = "delete"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
        let postString =
       "description=update&" +
       "datecreation=2020-12-12T08:00:00.000Z&"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")

                if(responseString?.contains("true"))!{
                    print("status = true")
                }
                else{
                    print("Status = false")
                }
            }

            task.resume()
        }
}
