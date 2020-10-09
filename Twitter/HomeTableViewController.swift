//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sanzida Sultana on 10/5/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    // Container of tweets
    var tweetsArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let refreshControls = UIRefreshControl()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        navigationController?.navigationBar.tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        loadTweets()
        
        // When User trys to reload the screen
        refreshControls.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refreshControls
     
    }
    
    // Method to call the tweets API
    @objc func loadTweets(){
        
        numberOfTweets = 20
        
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let param = ["counts": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: param, success: { (tweets: [NSDictionary]) in
            
            self.tweetsArray.removeAll()
            
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refreshControls.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    
    // Load more tweets
    func loadMoreTweets(){

        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let param = ["counts": numberOfTweets]

        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: param, success: { (tweets: [NSDictionary]) in

            self.tweetsArray.removeAll()
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            self.tableView.reloadData()

        }, failure: { (Error) in
            print("Could not retrieve tweets")
            print(Error.localizedDescription)
        })

    }
 
//
//    // When the user scrolls and gets to the end of the table if the number of cells is the same as the amount of tweets in the array then loadmoretweets
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetsArray.count {
            loadMoreTweets()
        }
    }
    
    
    @IBAction func touchedLogOutButton(_ sender: Any) {
        print("User clicked Log Out Button")
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "LoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let user = tweetsArray[indexPath.row]["user"] as! NSDictionary
        
        cell.username.text = user["name"] as! String
        cell.userTweet.text = tweetsArray[indexPath.row]["text"] as! String
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.profilePic.image = UIImage(data: imageData)
        }

        
        
        return cell
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetsArray.count
    }

}
