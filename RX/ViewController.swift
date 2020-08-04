//
//  ViewController.swift
//  RX
//
//  Created by Павел on 7/27/20.
//  Copyright © 2020 Павел. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        searchBarConfigure()
        
        repositoriesViewModel = ViewModel(APIProvider: api)
        
        if let viewModel = repositoriesViewModel{
            viewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell")){
                _, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
            }.disposed(by: disposeBag)
            
            searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
            searchBar.rx.cancelButtonClicked.map{" "}.bind(to: viewModel.searchText)
            
            viewModel.data.asDriver()
                .map{
                    "\($0.count) Repositories"
            }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        }
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar {return searchController.searchBar}
    
    var repositoriesViewModel: ViewModel?
    let api = APIprovider()
    let disposeBag = DisposeBag()
    
    func searchBarConfigure(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "PavlikVasil"
        searchBar.placeholder = "Enter user"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

