//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var statusMessages: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160

        reload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        var params = NSMutableDictionary()
        params["limit"] = 100
        FBRequestConnection.startWithGraphPath("/me/feed", parameters: params as [NSObject : AnyObject], HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            println("\(result)")
            var data = result as! NSDictionary
            self.statusMessages = data["data"] as! NSArray
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var status = self.statusMessages[indexPath.row] as! NSDictionary
        
        println("\(status)")
        
        var cell = UITableViewCell()
        
        if let description = status["description"] as! String? {
        
            if let picture = status["picture"] as! String? {
                // photo cell
                var photoCell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
                photoCell.statusLabel.text = description
                photoCell.statusLabel.sizeToFit()
                
                photoCell.photoImageView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string:picture)!), placeholderImage: nil, success: { (request, response, image) -> Void in
                    photoCell.photoImageView.image = image
                    photoCell.photoImageView.frame = CGRect(x:0, y:0, width:image.size.width, height:image.size.height)
//                    photoCell.photoImageView.sizeToFit()
                }, failure: { (request, response, error) -> Void in
                    
                })
                return photoCell
            } else {
                // message cell
                var statusCell = tableView.dequeueReusableCellWithIdentifier("StatusCell") as! StatusCell
                statusCell.statusLabel.text = description
                statusCell.statusLabel.sizeToFit()
                return statusCell
            }
        } else {
            cell.frame = CGRect(x:0, y:0, width:0, height:0)
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statusMessages == nil {
            return 0
        }
        return statusMessages!.count
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
