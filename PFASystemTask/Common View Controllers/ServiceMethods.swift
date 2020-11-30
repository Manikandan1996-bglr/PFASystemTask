//
//  ServiceMethods.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import Foundation
enum AuthResult {
    case success(Dictionary<String, Any>), failure(String)
}

func getResponse(completion: @escaping(AuthResult) ->()) {
    getCall { (result) in
        completion(result)
    }
}

func getCall(completion: @escaping (AuthResult) -> ()) {
    
    let urlString = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-10-30&sortBy=publishedAt&apiKey=da5000cc14da4d28aafaa260d824a384"
    let url: NSURL = NSURL(string: urlString)!
    var urlRequest = URLRequest(url: url as URL)
    urlRequest.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in

        DispatchQueue.main.async {
            //SKActivityIndicator.dismiss()
        }

        guard error == nil else {
            completion(.failure(error!.localizedDescription))
            return
        }

        guard let responseData = data else {
            print("Error: did not receive data")
            DispatchQueue.main.async {
                //Toast(text: "Did not receive data.").show()
            }
            completion(.failure("Did not receive data"))
            return
        }

        do {
            guard let response = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                    DispatchQueue.main.async {
                        //Toast(text: "Invalid Json data.").show()
                    }
                    completion(.failure("Invalid Json data"))
                    return
            }

            print("Response\(response)")

            completion(.success(response))


        } catch  {
            DispatchQueue.main.async {
                //Toast(text: "error trying to convert data to JSON.").show()
            }
            print("error trying to convert data to JSON")
            return
        }
    }
    task.resume()
}
