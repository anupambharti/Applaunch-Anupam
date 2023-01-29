//
//  ViewController.swift
//  Applaunch-Anupam
//
//  Created by Anu on 25/01/23.
//

import UIKit
import UIKit
import Alamofire
import Foundation
import SwiftyJSON
import Foundation
import Kingfisher

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var company: UITextView!
    @IBOutlet weak var launchesTable: UITableView!
    
    var launches:[Launch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetCompanyInfo()
        GetAllLaunches()
        launchesTable.delegate = self
        launchesTable.dataSource = self
      
    }

    func GetCompanyInfo() {
        
            let url = "https://api.spacexdata.com/v4/company"

            //Json Fetch
            AF.request(url).validate().responseJSON { [self] response in
                switch response.result {
                case .success:
    
                    if let json = response.data {
                        do{
                            let data = try JSON(data: json)
                    
                            let companyName = data["name"]
                            let founderName = data["founder"]
                            let year = data["founded"]
                            let employees = data["employees"]
                            let launch_sites = data["launch_sites"]
                            let valuation = data["valuation"]
                            
                         let companyDetails = ("\(companyName) was founded by \(founderName) in \(year). It has now \(employees),\(launch_sites) launch sites, and is valued at USD \(valuation)")
                            
                            DispatchQueue.main.async {
                                self.company.text = companyDetails
                                }
                        }
                        catch{
                            print("JSON Error")
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
    } ///GetCompanyInfo close
    
    
    func GetAllLaunches() {
    
            let url = "https://api.spacexdata.com/v4/launches"
        
           // Json Fetch
            AF.request(url).validate().responseJSON { [self] response in
                switch response.result {
                case .success:

                    if let json = response.data {
                        do{
                            self.launches = try! JSONDecoder().decode([Launch].self, from: json)
                            //print(launches)
//                                  let urlImage = URL(string: "https://images2.imgbox.com/6c/cb/na1tzhHs_o.png")
//                                 patch.kf.setImage(with: urlImage)
                               //   print(urlImage)
                            launchesTable.reloadData()
                            }
                        catch{
                            print("JSON Error")
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
    } ///GetAllaunch function close
} /// View Controller

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell",for: indexPath) as! LaunchCell
        cell.namee.text = self.launches[indexPath.row].name
        cell.rocket.text = self.launches[indexPath.row].rocket
       // cell.success.text = self.launches[indexPath.row].success
       //cell.imageView.image = urlImage
       
            return cell
    }
} /// Extension

///Cell
class LaunchCell: UITableViewCell {
    
    @IBOutlet weak var namee: UILabel!
    @IBOutlet weak var rocket: UILabel!
}
