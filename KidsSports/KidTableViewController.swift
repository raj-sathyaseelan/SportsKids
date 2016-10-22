//
//  KidTableViewController.swift
//  KidsSports
//
//  Created by Raj Sathyaseelan on 10/1/16.
//  Copyright © 2016 Token. All rights reserved.
//

import UIKit

class KidTableViewController: UITableViewController {
    
    var kids = [Kid]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredKids = [Kid]()
    
    func filterKidbySearchCity (searchCity: String, scope: String = "All") {
        
        filteredKids = kids.filter {kid in
            let schoolMatch = (scope == "All") || (kid.schoolName == scope)
        return schoolMatch && "\(kid.firstName) \(kid.lastName)".lowercased().contains(searchCity.lowercased())
        }
        
        self.tableView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleData()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.scopeButtonTitles = ["All", "Coyote Creek", "Quail Run"]
        searchController.searchBar.delegate = self
        
    }
    
    func loadSampleData() {
        
        
        var kidSports = [Sport]()
        
        
        let sport1 = Sport(sportName: "Basketball", sportIcon: "basketball-1")
        let sport2 = Sport(sportName: "Baseball", sportIcon: "baseball")
        
        kidSports += [sport1, sport2]
        
        let kidPhoto1 = UIImage(named: "kid1")!
        let kid1 = Kid(firstName: "Joe", lastName: "Buck", photo: kidPhoto1, schoolName: "Coyote Creek", age: 6, sports: kidSports)
        
        let kidPhoto2 = UIImage(named: "kid2")!
        let kid2 = Kid(firstName: "James", lastName: "Callaghan", photo: kidPhoto2, schoolName: "Quail Run", age: 7, sports: kidSports)
        
        let kidPhoto3 = UIImage(named: "kid3")!
        let kid3 = Kid(firstName: "Jill", lastName: "Johnson", photo: kidPhoto3, schoolName: "Coyote Creek", age: 6, sports: kidSports)
        
        
        let kid4 = Kid(firstName: "Calm", lastName: "Johnson", photo: kidPhoto3, schoolName: "Coyote Creek", age: 7, sports: kidSports)
        
        
        kids += [kid1, kid2, kid3, kid4]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredKids.count
        }
        return kids.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "KidTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KidTableViewCell
        let kid: Kid
        let cellImageView = cell.photoUIImage
        
        if searchController.isActive && searchController.searchBar.text != "" {
            kid = filteredKids[indexPath.row]
        } else {
            kid = kids[indexPath.row]
        }

        cell.kidNameLabel.text = "\(kid.firstName)  \(kid.lastName)"
        cell.schoolNameAgeLabel.text = "\(kid.schoolName), \(kid.age)"
        cellImageView?.image = resizeImage(image: kid.photo, newWidth: 50)
        cellImageView?.contentMode = UIViewContentMode.scaleAspectFit;
        
        var arrangedImages = [UIView]()
        let playLabel = UILabel()
        playLabel.text = "Plays:"
        playLabel.font = playLabel.font.withSize(14)
        arrangedImages += [playLabel]
        
        
        //loop sports array
        for sport in kid.sports {
            let sportImage = UIImage(named: sport.sportIcon)
            let sportImageView = UIImageView(image: resizeImage(image: sportImage!, newWidth: 30))
            sportImageView.contentMode = .scaleAspectFit
            arrangedImages += [sportImageView]
        }
        
        let stackView = UIStackView(arrangedSubviews: arrangedImages)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        cell.kidStackView.addArrangedSubview(stackView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Here, we use NSFetchedResultsController
        // And we simply use the section name as title
        
        let title = self.tableView(tableView, titleForHeaderInSection: section)
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell") as! CustomHeaderCell
        //headerCell.backgroundColor = UIColor.cyan()
        headerCell.headerLabel.text = title
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //let title = self.tableView(tableView, titleForHeaderInSection: section)
        
        let  footerCell = tableView.dequeueReusableCell(withIdentifier: "CustomFooterCell") as! CustomFooterCell
        //headerCell.backgroundColor = UIColor.cyan()
        footerCell.footerButton.setTitle("Change City", for: UIControlState .normal)
        return footerCell

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch(section)
        {
        case 0:
            return "Congrats, \"565\" neigbours in your city!"
        default:
            return "No name"
        }
    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //code
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension KidTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        filterKidbySearchCity(searchCity: searchController.searchBar.text!, scope: scope)
    }
    
}

extension KidTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterKidbySearchCity(searchCity: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
