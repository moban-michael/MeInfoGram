//
//  MyInfoListViewController.swift
//  MeInfoGram
//
//  Created by Moban Michael on 20/11/2020.
//

import UIKit
import RxSwift

class MyInfoListViewController: UIViewController { //MyInfoListViewController
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var myInfoList      = [MyInfo]()
    fileprivate var filteredList    = [MyInfo]()
    fileprivate var isFilterring    = false
    private let disposeBag          = DisposeBag()
    var selectedMyInfo              : MyInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        loadData()
    }
    
    override func backClicked() {
        LoginManager.shared.state = .loggedout
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UI
    fileprivate func setUpUI(){
        title = "My Info"
        self.setLeftBackBarButtonItem()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    //MARK: Loading Data
    func loadData(){
        let secureDataListViewModal       = MyInfoListViewModal()
        secureDataListViewModal.myInfoList.asObservable().subscribe { (event) in
            if let secureDataList = event.element{
                self.myInfoList.removeAll()
                self.myInfoList.append(contentsOf: secureDataList)
                onMainQueue {
                    self.tableView.reloadData()
                }
            }
        }.disposed(by: self.disposeBag)
        
        DispatchQueue.global(qos: .background).async {
            secureDataListViewModal.getSecureDataList()
        }
        
    }
}

private typealias TableViewDataSource = MyInfoListViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.isFilterring ? self.filteredList.count : myInfoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFilterring ? self.filteredList[section].items.count : myInfoList[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Identifier", for: indexPath)
        cell.textLabel?.text = self.isFilterring ? self.filteredList[indexPath.section].items[indexPath.row].headerTitle : self.myInfoList[indexPath.section].items[indexPath.row].headerTitle
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.isFilterring ? self.filteredList[section].category.rawValue : self.myInfoList[section].category.rawValue
    }
}

private typealias TableViewDelegate = MyInfoListViewController
extension TableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedMyInfo = myInfoList[indexPath.row]
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0))
        performSegue(withIdentifier: "Load Detail", sender: cell)
    }
}

private typealias SearchResultsDelegate = MyInfoListViewController
extension SearchResultsDelegate: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            
            var outerList: [MyInfo] = []
            for myInfo in self.myInfoList {
                var innerList: [Item] = []
                for item in myInfo.items{
                    if item.headerTitle.lowercased().contains(text.lowercased()){
                        innerList.append(item)
                    }
                }
                if innerList.count > 0 {
                    outerList.append(MyInfo.init(item: innerList, category: myInfo.category))
                }
            }
            self.filteredList = outerList
            self.isFilterring = true
        }
        else {
            self.isFilterring = false
            self.filteredList = [MyInfo]()
        }
        self.tableView.reloadData()
    }
}

private typealias AddNewItem = MyInfoListViewController
extension AddNewItem {
        
    @IBAction func addNewTapped(_ sender: Any) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PopupView") as! FilterPopUpViewController
//        vc.hospitals = listAndHeader
//        vc.selectedFilter.asObservable().subscribe { (event) in
//            if let selectedFilter = event.element{
//                if selectedFilter.0 == FilterCategory.None{
//                    self.isFilterring = false
//                    self.filteredList = [Hospital]()
//                }else{
//                    self.filteredList.removeAll()
//                    self.isFilterring = true
//                    self.filteredList = self.hospitalListViewModal.getFilteredHospitalList(hospitals: self.hospitals, selectedFilter: selectedFilter)
//                }
//                self.tableView.reloadData()
//            }
//        }.disposed(by: self.disposeBag)
//        vc.modalPresentationStyle = UIModalPresentationStyle.popover
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.barButtonItem = sender
//        popover.delegate = self
//        present(vc, animated: true, completion:nil)
    }
}
