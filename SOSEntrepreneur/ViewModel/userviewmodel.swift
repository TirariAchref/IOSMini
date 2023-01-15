//
//  userviewmodel.swift
//  doctor
//
//  Created by achref on 19/11/2021.
//

import Foundation
import Alamofire
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
class userVM {
  
    var userdata = [User]()
    var tokenString : String?
    var useronhold: User?
    var userToken : User?
    var userByemail : User?
    var userByid : User?
    var regestirUser : User?
    @Published var isAuthenticated : Bool = false
    
    func getOwnerToy(OwnerId:String, successHandler: @escaping (_ anomalyList: User) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/getuser/"+OwnerId
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in
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
    //alomofire update toy
        func updateToys(Image:UIImage,toy:User?,successHandler: @escaping (_ toy: User?) -> (),errorHandler: @escaping () -> ())
        {
            let urlApi = "http://localhost:3000/updateImageClient/"+(toy?._id)!
            print(urlApi)
            let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]

            
        AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(Image.jpegData(compressionQuality: 0.5)!, withName: "Image" , fileName: "Image.jpeg", mimeType: "Image/jpeg")

              
        },to: urlApi, method: .post , headers: headers).responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in

                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
        
                switch apiResponse.response?.statusCode {
                    case 200:
                        successHandler(try! apiResponse.result.get())
                    case 500:
                    print("Error 500 update toy")
                        errorHandler()
                default:
                    errorHandler()
                }
            }
        
        }

    func getOwnermail(OwnerId:String, successHandler: @escaping (_ anomalyList: [User]) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/getuserEmail/"+OwnerId
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of: [User].self, decoder: JSONDecoder()) { apiResponse in
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
    func getallusers(){
       
        
        let jsonUrlString = "http://localhost:3000/allusers"
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {

                    let Allusers = try JSONDecoder().decode([User].self, from: data)
                   
                    Allusers.forEach { user in self.userdata.append(user) }
                
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
      

       
    }
    func getuserfromtoken(token : String){
       
        print("Token : ----------------------")
        print(token)
        let jsonUrlString = "http://localhost:3000/tokenaccount"
            guard let url = URL(string: jsonUrlString) else
            { return }
        var request = URLRequest(url: url)
             request.addValue(token, forHTTPHeaderField: "authorization")
            URLSession.shared.dataTask(with: request) { (data, response, err) in
              
                guard let data =  data else{ return }

                do {

                    let Allusers = try JSONDecoder().decode(User.self, from: data)
                   
                   
                    DispatchQueue.main.async {
                        self.userToken = Allusers
                    }
                    print("name = " + Allusers.nom!)
                    print("email = " + Allusers.email!)
                    print("phone = " + Allusers.phone!)
                   
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
      

       
    }
    
    func createtoken(email:String,password:String) {
        let defaults = UserDefaults.standard
            var request = URLRequest(url: URL(string: "http://localhost:3000/loginClient")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "email="+email+"&"+"password="+password+"&"
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
               

                let json = responseString!.toJSON() as? [String:AnyObject]
                let tt = json!["token"] as? String
                self.tokenString = json!["token"] as? String
                defaults.setValue(self.tokenString, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    print(self.isAuthenticated)
                }
                if((tt) != nil){
                    self.getuserfromtoken(token:(json!["token"] as? String)!)
                }
               
               
                if(responseString?.contains("true"))!{
                    print("status = true")
                }
                else{
                    print("Status = false")
                }
            }

            task.resume()
        }
    
    func signout() {
               
               let defaults = UserDefaults.standard
               defaults.removeObject(forKey: "jsonwebtoken")
               DispatchQueue.main.async {
                   self.isAuthenticated = false
                   print(self.isAuthenticated)
               }
               
           }
   
    func createuser(nom : String,prenom:String,email:String,password:String,phone:String,money:String,imageUrl:String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createuser")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "nom="+nom+"&"+"prenom="+prenom+"&"+"email="+email+"&"+"password="+password+"&"+"phone="+phone+"&"+"money="+money+"&"+"imageUrl="+imageUrl+"&"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }


                do {

                    let Allusers = try JSONDecoder().decode(User.self, from: data)
                   
                   
                    DispatchQueue.main.async {
                        self.regestirUser = Allusers
                    }
                    print("name = " + Allusers.nom!)
                    print("email = " + Allusers.email!)
                    print("phone = " + Allusers.phone!)
                    print("imageurl = " + Allusers.imageUrl!)
                   
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }

            task.resume()
        }
    
    
    func updateuser(id:String,nom : String,prenom:String,email:String,password:String,phone:String,money:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updateuser/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "nom="+nom+"&"+"prenom="+prenom+"&"+"email="+email+"&"+"password="+password+"&"+"phone="+phone+"&"+"money="+money+"&"
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
    func updateuserpass(id:String,nom : String,prenom:String,email:String,phone:String,money:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updateuserpass/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "nom="+nom+"&"+"prenom="+prenom+"&"+"email="+email+"&"+"phone="+phone+"&"+"money="+money+"&"
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
    
    func updatemap(id:String,log : String,lat:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updatemap/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "log="+log+"&"+"lat="+lat+"&"
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
    
    func deleteuser(id:String){
        var request = URLRequest(url: URL(string: "http://localhost:3000/deleteuser/"+id)!)
            request.httpMethod = "delete"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString =    "nom=tirari&" +
            "prenom=tirari&" +
            "email=tirari@abc.vom&" +
            "password=tirari&" +
            "phone=tirari&" +
            "categorieclient=tirari&"
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
    
    func getbyemail(email : String){
       
        
        let jsonUrlString = "http://localhost:3000/getuserEmail/"+email
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {

                    let Allusers = try JSONDecoder().decode([User].self, from: data)
                   
                    Allusers.forEach { user in self.userByemail = user }
                
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
      

       
    }
    
    
    func getbyId(id : String){
       
        
        let jsonUrlString = "http://localhost:3000/getuser/"+id
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.userByid = try JSONDecoder().decode(User.self, from: data)
                
                    
                    print((self.userByid)!)
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
      

       
    }
    
    func sendmail(email:String,code:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/sendmail")!)
             request.httpMethod = "post"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "email="+email+"&"+"code="+code+"&"
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
    func sendsms(code:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/sendsms")!)
             request.httpMethod = "post"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "code="+code+"&"
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
