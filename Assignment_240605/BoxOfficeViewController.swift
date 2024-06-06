//
//  BoxOfficeViewController.swift
//  Assignment_240605
//
//  Created by 김상규 on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

class BoxOfficeViewController: UIViewController {
    
    lazy var textField: UITextField = {
       let tf = UITextField()
        tf.font = .systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "형식에 맞게 입력해주세요 ex) 20240506", attributes: [.foregroundColor: UIColor.lightGray])
        tf.backgroundColor = .clear
        
        return tf
    }()
    
    lazy var textFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .gray
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(getBoxofficeInfo), for: .touchUpInside)
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.reloadData()
        
       return tableView
    }()
    
    var movies: [DailyBoxOfficeInfo] = []
    var date = DateFormatter.dateFormat(Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        getBoxofficeInfo()
    }
    
    func configureHierarchy() {
        // MARK: addSubView()
        view.addSubview(textFieldLine)
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        textField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
        
        textFieldLine.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(textField.snp.bottom)
            make.width.equalTo(textField.snp.width)
            make.height.equalTo(4)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(textField.snp.trailing).offset(12)
            make.height.equalTo(48)
            make.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    }

    @objc func getBoxofficeInfo() {
        guard let textdate = textField.text else { return }
        if !textdate.isEmpty {
            date = textdate
        }
        let url = "\(MovieAPIKey.moviewURL)?key=\(MovieAPIKey.movieKey)&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: Boxoffice.self) { response in
            switch response.result {
            case .success(let value):
                self.movies = value.boxOfficeResult.dailyBoxOfficeList
                self.tableView.isHidden = false
                self.tableView.reloadData()
                print(self.movies)
            case.failure(let error):
                self.textField.text = ""
                self.textField.placeholder = "알맞은 형식을 입력해주세요 ex) 20240606"
                self.tableView.isHidden = true
                print("\(error)")
            }
        }
    }

}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell
        let data = movies[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.setLabelTitle(data: data)
        
        
        return cell
    }
}

extension DateFormatter {
    static func dateFormat(_ date: Date) -> String {
        let y = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyyMMdd"
        
        print(myDateFormatter.string(from: y))
        return myDateFormatter.string(from: y)
    }
}
