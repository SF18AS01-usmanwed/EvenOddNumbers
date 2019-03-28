//
//  MenuController.swift
//  Restaurant
//
//  Created by Ousmane Ouedraogo on 3/21/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import Foundation

class MenuController {
    static let shared = MenuController()
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    var order = Order(){
        didSet {
            NotificationCenter.default.post(name:
                MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    
    func fetchCategories(completion: @escaping ([String]?) -> Void)
    {
         let categoryURL =
            baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL)
        { (data, response, error) in
             if let data = data,
                let jsonDictionary = try?
                    JSONSerialization.jsonObject(with: data) as?
                        [String:Any],
                let categories = jsonDictionary?["categories"] as?
                    [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
        
    }
    
    func fetchMenuItems(forCategory categoryName: String,
                        completion: @escaping
        ([MenuItem]?) -> Void) {
        
          let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL,
                                       resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category",
                                              value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self,
                                                        from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    
        func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {   //p. 910
            let orderURL: URL = baseURL.appendingPathComponent("order");   //p. 911
            var request: URLRequest = URLRequest(url: orderURL);   //p. 912
            request.httpMethod = "POST";
            request.setValue("application/json", forHTTPHeaderField: "Content-Type");
            
            let data: [String: [Int]] = ["menuIds": menuIds];   //p. 913
            let jsonEncoder: JSONEncoder = JSONEncoder();
            let jsonData: Data? = try? jsonEncoder.encode(data);
            request.httpBody = jsonData;
            
            let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in //p. 914
                let jsonDecoder: JSONDecoder = JSONDecoder();   //p. 915
                if let data: Data = data,
                    let preparationTime: PreparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) { //p. 916
                    completion(preparationTime.prepTime);
                } else {
                    completion(nil);
                }
            }
            
            task.resume();
        }
}
    func fetchImage(url: URL, completion: @escaping (UIImage?) ->
        Void) {
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {           completion(nil)
            }
        }
        task.resume()
    }
}
