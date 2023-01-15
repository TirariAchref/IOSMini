//
//  userviewmodel.swift
//  doctor
//
//  Created by achref on 19/11/2021.
//

import Foundation
import Alamofire
class messagerieVM {
  
    var listmessagerie = [Messagerie]()
    func getOwnerToy(successHandler: @escaping (_ anomalyList: [Messagerie] ) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/allmessagerie"
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of:  [Messagerie].self, decoder: JSONDecoder()) { apiResponse in
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
    func getallmessageries()  {
       
        
        let jsonUrlString = "http://localhost:3000/allmessagerie"
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.listmessagerie.removeAll()
                    let messageries = try JSONDecoder().decode([Messagerie].self, from: data)
                 
                    messageries.forEach { messagerie in self.listmessagerie.append(messagerie) }
                  
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
    }
    
    
   
    func createmessagerie(message:String ,object:String ,from:String , to:String  ){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createmessagerie")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
        let postString = "message="+message+"&"+"object="+object+"&"+"from="+from+"&"+"to="+to+"&"
         
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
    
   
    func deletemessagerie(id:String){
        var request = URLRequest(url: URL(string: "http://localhost:3000/deletemessagerie/"+id)!)
            request.httpMethod = "delete"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
        let postString =
       "message=create&" +
       "object=create&" +
       "datecreation=2020-12-12T08:00:00.000Z&" +
       "from=String&"
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
