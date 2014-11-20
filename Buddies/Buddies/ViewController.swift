/*
* JBoss, Home of Professional Open Source.
* Copyright Red Hat, Inc., and individual contributors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit


class MasterViewController: UITableViewController {

    var http = Http()
    var data = [Developer]()
    var serializer = JsonSZ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        http.GET("http://igtests-cvasilak.rhcloud.com/rest/team/developers", completionHandler: { (response: AnyObject?, error: NSError?) -> Void in
            if (response != nil) {
            
                for developerJson in (response!) as [AnyObject] {
                    let developerObject = self.serializer.fromJSON(developerJson, to: Developer.self)
                    println(":::::\(developerObject)")
                    self.data.append(developerObject)
                }
                self.tableView.reloadData()
            }
            if error != nil {
                println("An error has occured during read! \(error!)")
            }
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let developer = data[indexPath.row]
        cell.textLabel.text = developer.name
        cell.detailTextLabel?.text = developer.twitter
        cell.tag = indexPath.row
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), {
            // todo safe unwrap
            var imageData = NSData(contentsOfURL: NSURL(string: developer.image!)!)
            
            dispatch_async(dispatch_get_main_queue(), {
                if cell.tag == indexPath.row {
                    cell.imageView.image = UIImage(data: imageData!)
                    cell.setNeedsLayout()
                }
            })
        })
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let developer = data[indexPath.row]
        let twitterURL: NSURL = NSURL(string:"http://twitter.com/\(developer.twitter)")!
        UIApplication.sharedApplication().openURL(twitterURL)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

class Developer: JSONSerializable {
    
    var name: String?
    var twitter: String?
    var image: String?
    
    init(name: String, twitter: String, image: String) {
        self.name = name
        self.twitter = twitter
        self.image = image
    }
    
    required init() {}
    
    class func map(source: JsonSZ, object: Developer) {
        object.name <= source["name"]
        object.twitter <= source["twitter"]
        object.image <= source["photoURL"]
    }

}
extension Developer: Printable {
    var description: String {
        get {
            var description = ">>"
            if let name = name {
                description += "name:\(name) "
            }
            if let twitter = twitter {
                description += "twitter:\(twitter) "
            }
            if let image = image {
                description += "image:\(image) "
            }
            return description
        }
    }
}
