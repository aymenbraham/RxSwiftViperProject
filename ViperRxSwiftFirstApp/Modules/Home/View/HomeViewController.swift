//
//  HomeViewController.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 14/02/2022.
//

import UIKit
import RxSwift
import Moya
import AlamofireImage

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var menuTableView: UITableView!
    
    // MARK: Variables
    var buttonCart: UIButton?
    var labelCart: UILabel?
    var homePresenter: HomePresenterProtocol?
    private let disposeBag = DisposeBag()
    var selectedIndex = IndexPath(row: 0, section: 0)
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.homePresenter?.inPuts.viewDidload()
    }
    
    override func awakeFromNib() {
        setUpConfig()
    }
    
    
    // MARK: SetUp View
    private func setUpView() {
        setUpTableView()
    }
    
    private func setUpConfig() {
        
        let failuerEndPointClosure = { (target: MenuService) -> Endpoint in
            let sampleResponseClosure = { () -> EndpointSampleResponse in
                return .networkResponse(200, target.sampleData)
            }
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        
        let provider = MoyaProvider<MenuService>(endpointClosure: failuerEndPointClosure,  stubClosure: MoyaProvider.immediatelyStub)
        
        let interactor = HomeInteractor.init(provider: provider)
        let router = HomeRouter()
        let dependencies = HomePresenterDependecies(interactor: interactor, router: router)
        let presenter = HomePresenter(dependecies: dependencies)
        self.homePresenter = presenter
        
        // Data Binding
        presenter.menuList.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.menuTableView.reloadData()
            }).disposed(by: disposeBag)
        
        presenter.categoryList.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.categoryCollectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setUpTableView() {
        menuTableView.register(UINib(nibName: cellMenuIdentifier, bundle: nil), forCellReuseIdentifier: cellMenuIdentifier)
        menuTableView.separatorStyle = .none
    }
    
    func animateButton()
    {
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = false
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1
        animationGroup.animations = [pulse1]
        
        self.labelCart?.layer.add(animationGroup, forKey: "pulse")
    }
    
    
}

// MARK: TableView Delegate && DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, CellOutput {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = homePresenter?.outPuts.menuList.value.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellMenuIdentifier, for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        let menu = self.homePresenter?.outPuts.menuList.value[indexPath.row]
        if let url = URL(string: menu?.menuImageUrl ?? "") {
            cell.imgView.af.setImage(withURL:url)
        }
        cell.title.text = menu?.menuName
        cell.desc.text = menu?.MenuDesc
        cell.content.text = menu?.menuContent
        let price =  menu?.menuPrice ?? ""
        cell.buttonOrder.setTitle("\(price) usd", for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func buttonClicked(sender: AnyObject) {
        let indexPath = self.menuTableView.indexPath(for: sender as! UITableViewCell)
        
        if  let order = self.homePresenter?.outPuts.menuList.value[indexPath!.row]  {
            // self.homePresenter?.inPuts.addToCart(order: [order])
            // animateButton()
        }
    }
}

// MARK: CollectionView Delegate && DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePresenter?.outPuts.categoryList.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCategorieIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        let item  = self.homePresenter?.outPuts.categoryList.value[indexPath.row]
        if let string = item
        {
            cell.title.text = string
        }
        cell.setSelected(selectedIndex.row == indexPath.row, animated: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath != selectedIndex) {
            let indexPath_pre = selectedIndex
            let indexPath_post = indexPath
            let array = [indexPath_pre,indexPath_post]
            self.selectedIndex = indexPath
            collectionView.reloadItems(at: array)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item  = self.homePresenter?.outPuts.categoryList.value
        if let count = item?.count
        {
            let value = (Int(count) *  13) + 32
            return CGSize(width: value, height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
}
