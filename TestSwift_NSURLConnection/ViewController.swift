//
//  ViewController.swift
//  TestSwift_NSURLConnection
//
//  Created by Eduardo Flores on 3/24/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let URL_CAR_1 = "http://i.telegraph.co.uk/multimedia/archive/02556/Ford-Fiesta-2_2556130k.jpg"
    let URL_CAR_2 = "http://i.telegraph.co.uk/multimedia/archive/01433/cruze1_1433175c.jpg"
    
    
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button_useNSURLConnection(sender: AnyObject)
    {
        let url = NSURL(string: URL_CAR_1)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
            {
                var responseError: NSError?
                var data = NSURLConnection.sendSynchronousRequest(request,
                    returningResponse: AutoreleasingUnsafeMutablePointer<NSURLResponse?>(),
                    error: &responseError)
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        self.label_status.text = "Selected NSURLConnection"
                        self.imageView.image = UIImage(data: data!)
                    })
            }
    }//end button_useNSURLConnection
    
    
    func getURLSession() -> NSURLSession
    {
        var session:NSURLSession
        
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration)
       
        return session;
    }//end getURLSession
    
    @IBAction func button_useNSURLSession(sender: AnyObject)
    {
        let url = NSURL(string: URL_CAR_2)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        var task = getURLSession().dataTaskWithRequest(request)
            { (data, response, error) -> Void in
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        self.label_status.text = "Selected NSURLSession"
                        self.imageView.image = UIImage(data: data!)
                    })
            }
        
        task.resume()
    }//end button_useNSURLSession

}//end class






































