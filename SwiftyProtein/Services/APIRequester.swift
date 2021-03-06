//
//  APIRequester.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import Alamofire

class APIRequester {

	static let sharedInstance = APIRequester()
    
    let baseLigandUrl: String = "http://file.rcsb.org/"
    let baseLigandInfosUrl: String = "http://www.rcsb.org/"

	init() {
	}

	func request(method: Method, URLString: URLStringConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String : String]? = nil, completionHandler: Response<NSData, NSError> -> Void) {

		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		Alamofire.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseData { (response) in

			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			completionHandler(response)

		}

	}

	func requestLigand(ligandName: String, completionHandler: Response<NSData, NSError> -> Void) {
		self.request(.GET, URLString: "\(self.baseLigandUrl)ligands/download/\(ligandName)_model.pdb", completionHandler: completionHandler)
	}

    func requestInfoLigand(ligandName: String, completionHandler: Response<NSData, NSError> -> Void) {
        self.request(.GET, URLString: "\(self.baseLigandInfosUrl)pdb/rest/describeHet?chemicalID=\(ligandName)", completionHandler: completionHandler)
    }
    
}
