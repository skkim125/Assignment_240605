//
//  ViewController.swift
//  Assignment_240605
//
//  Created by 김상규 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    let roundTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "회차를 입력해주세요"
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        
        return tf
    }()
    
    let infoNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        
        return label
    }()
    
    let lottoDatelabel: UILabel = {
        let label = UILabel()
        label.text = "2020년20월20일"
        
        return label
    }()
    
    let roundLabel: UILabel = {
        let label = UILabel()
        label.text = "888회"
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        
        return label
    }()
    
    let resultTextLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 32, weight: .medium)
        
        return label
    }()
    
    lazy var lottoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: numberViews)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        
        return stackView
    }()
    
    let numberlabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "45"
        label.textColor = .white
        label.backgroundColor = .blue
        
        return label
    }()
    
    let numberlabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "45"
        label.textColor = .white
        label.backgroundColor = .red
        
        return label
    }()
    
    let numberlabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "45"
        label.textColor = .white
        label.backgroundColor = .brown
        
        return label
    }()
    
    let numberlabel4: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "45"
        label.textColor = .white
        label.backgroundColor = .darkGray
        
        return label
    }()
    
    func configureLottoLabelUI(view: UILabel, num: Int) -> UIView {
        let label = view
        
        label.textAlignment = .center
        label.text = "\(num)"
        label.textColor = .white
        label.backgroundColor = .black
        
        return view
    }
    
    lazy var numberlabel5: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "2"
        label.textColor = .white
        label.backgroundColor = .green

        return label
    }()
    
    let numberlabel6: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "45"
        label.textColor = .white
        label.backgroundColor = .black
        
        return label
    }()
    
    let plusView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "plus")
        view.tintColor = .lightGray
        
        return view
    }()
    
    let numberlabel7: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "45"
        label.textColor = .white
        label.backgroundColor = .black
        
        return label
    }()
    
    let bonusLabel: UILabel = {
        let label = UILabel()
        label.text = "보너스"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        
        return label
    }()
    
    var numbers: [Int] = []
    var round: Int = 1120
    
    lazy var numberViews: [UIView] = [numberlabel1, numberlabel2, numberlabel3, numberlabel4, numberlabel5, numberlabel6, plusView, numberlabel7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        // MARK: addSubView()
        view.addSubview(roundTextField)
        view.addSubview(infoNumberLabel)
        view.addSubview(lottoDatelabel)
        view.addSubview(roundLabel)
        view.addSubview(resultTextLabel)
        view.addSubview(lottoStackView)
        view.addSubview(bonusLabel)
    }
    
    func configureLayout() {
        roundTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
        
        infoNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        lottoDatelabel.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        roundLabel.snp.makeConstraints { make in
            make.top.equalTo(infoNumberLabel.snp.bottom).offset(28)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        resultTextLabel.snp.makeConstraints { make in
            make.top.equalTo(infoNumberLabel.snp.bottom).offset(28)
            make.leading.equalTo(roundLabel.snp.trailing).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(roundLabel)
        }
        
        configureStackViewLayout()
        
        
    }
    
    func configureStackViewLayout() {
        
        lottoStackView.snp.makeConstraints { make in
            make.top.equalTo(resultTextLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(60)
        }
        
        for item in numberViews {
            item.snp.makeConstraints { make in
                make.height.equalTo(item.snp.width)
                print(make.height)
            }
            
            print(item.frame.width)
            print(item.frame.height)
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 20
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(numberlabel7.snp.centerX)
            make.top.equalTo(numberlabel7.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
    }
    
    func getLottoInfo() {
        
        
    }
}

extension ViewController: UIPickerViewDelegate {
    
}
