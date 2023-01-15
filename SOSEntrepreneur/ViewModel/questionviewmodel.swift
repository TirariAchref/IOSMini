//
//  userviewmodel.swift
//  doctor
//
//  Created by achref on 19/11/2021.
//

import Foundation
import Alamofire
class questionVM {
  var listquestion = [Question]()
    func getOwnerToy(successHandler: @escaping (_ anomalyList: [Question] ) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/allquestions"
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of:  [Question].self, decoder: JSONDecoder()) { apiResponse in
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
    func getallquestions()  {
       
        
        let jsonUrlString = "http://localhost:3000/allquestions"
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.listquestion.removeAll()

                    let questions = try JSONDecoder().decode([Question].self, from: data)
                 
                    questions.forEach { question in self.listquestion.append(question) }
                    
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
    }
    
    
   
    func createquestion(description : String , subject :String, idClient : String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createquestion")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString =
           "description="+description+"&" +
           "subject="+subject+"&" +
        "idClient="+idClient+"&" +
        "nbrrate="+"0"+"&" +
        "nbruser="+"0"+"&"
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
    
    
    func updatequestion(id : String , nbrrate : String , nbruser :String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updatequestion/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString =
         "nbrrate="+nbrrate+"&" +
         "nbruser="+nbruser+"&"
 
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
    
    func deletequestion(id : String){
        var request = URLRequest(url: URL(string: "http://localhost:3000/deletequestion/"+id)!)
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
