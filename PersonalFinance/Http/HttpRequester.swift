//
//  HttpRequester.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class HttpRequester {
    
    static let sharedInstance = HttpRequester()
    var delegate: HttpRequesterDelegate?

    func send(withMethod method: HttpMethod, toUrl url: URL?, withBody bodyDict: Data? = nil,
              andHeaders headers: [String: String] = [:]) {
        var request: URLRequest
        
        guard let url = url else {
            handleError(forHttpMethod: method, withError: "Could not construct URL")
            return
        }
        
        request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let bodyDict = bodyDict, method == .post {
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
                request.httpBody = bodyDict
            } catch {
                print("ERROR json serialization for url: \(url): \(error)")
            }
        }
        
        headers.forEach() {request.setValue($0.value, forHTTPHeaderField: $0.key)}
        let dataTask = URLSession.shared.dataTask(with: request) { (bodyData, response, error) in
            self.log(title: "REQUEST", with: response ?? "")
            guard error == nil else {
                if let errorMessage = error?.localizedDescription {
                    self.handleError(forHttpMethod: method, withError: errorMessage)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.handleError(forHttpMethod: method, withError: "Invalid response")
                return
            }
            
            switch httpResponse.statusCode {
            case 200...399:
                guard let responseData = bodyData else {
                    self.handleError(forHttpMethod: method, withError: "No data in response")
                    return
                }
                self.handleSuccess(forHttpMethod: method, withData: responseData)
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                    self.log(title: "RESPONSE", with: dict)
                } catch {
                    
                }
            default:
                guard let responseError = bodyData else {
                    self.handleError(forHttpMethod: method, withError: "Error cannot be parsed")
                    return
                }
                let err = try? JSONSerialization.jsonObject(with: responseError, options: .allowFragments)
                self.handleError(forHttpMethod: method, withError: String(describing: err))
                self.log(title: "ERROR", with: err ?? "")
            }
        }
        
        dataTask.resume()
        
    }
    
    func requestJSON(withMethod method: HttpMethod, toUrl url: URL?, withBody bodyDict: Data? = nil,
                     andHeaders headers: [String: String] = [:]) {
        send(withMethod: method, toUrl: url, withBody: bodyDict)
    }
    
    private func handleError(forHttpMethod httpMethod: HttpMethod, withError error: String) {
        switch httpMethod {
        case .get:
            delegate?.didGetFailed(error: error)
        case .post:
            delegate?.didPostFailed(error: error)
        }
    }
    
    private func handleSuccess(forHttpMethod httpMethod: HttpMethod, withData data: Data) {
        switch httpMethod {
        case .get:
            delegate?.didGetSuccess(data: data)
        case .post:
            delegate?.didPostSuccess(data: data)
        }
    }
    
    private func log(title: String, with: Any) {
        print("""
            ---------------------------------------------------------------------------
            --------------------------------- \(title) --------------------------------
            ---------------------------------------------------------------------------
            
            \(with)
            
            ---------------------------------------------------------------------------
            ---------------------------------------------------------------------------
            """)
    }
}

protocol HttpRequesterDelegate: class {
    func didGetSuccess(data: Data)
    func didGetFailed(error: String)
    
    func didPostSuccess(data: Data)
    func didPostFailed(error: String)
}
