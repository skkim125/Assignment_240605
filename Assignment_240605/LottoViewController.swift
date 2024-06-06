//
//  ViewController.swift
//  Assignment_240605
//
//  Created by 김상규 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit

class LottoViewController: UIViewController {
    
    lazy var roundTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "회차를 선택해주세요"
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(getLottoInfo), for: .editingDidEndOnExit)
        tf.inputView = roundPickerView
        
        return tf
    }()
    
    lazy var roundPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        
        return picker
    }()
    
    let infoNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var lottoDatelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    lazy var roundLabel: UILabel = {
        let label = UILabel()
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
    
    lazy var numberlabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .blue
        
        return label
    }()
    
    lazy var numberlabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        
        return label
    }()
    
    lazy var numberlabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .brown
        
        return label
    }()
    
    lazy var numberlabel4: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .darkGray
        
        return label
    }()
    
    lazy var numberlabel5: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .green

        return label
    }()
    
    lazy var numberlabel6: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
    
    lazy var numberlabel7: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
    lazy var round: Int = 1122
    lazy var currentRound: Int = LottoAPIKey.plusRound(&round)
    lazy var lottoList: [String] = []
    
    lazy var numberViews: [UIView] = [numberlabel1, numberlabel2, numberlabel3, numberlabel4, numberlabel5, numberlabel6, plusView, numberlabel7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "로또 알아보기"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
//        roundTextField.delegate = self
        roundPickerView.delegate = self
        roundPickerView.dataSource = self
        
        configureHierarchy()
        configureLayout()
        getLottoInfo()
        
        for i in 0...round {
            lottoList.append("\(i+1)")
        }
        lottoList.remove(at: lottoList.endIndex-1)
        print(lottoList.count)
    }
    
    func configureHierarchy() {
        // MARK: addSubView()
        view.addSubview(roundTextField)
        view.addSubview(roundPickerView)
        view.addSubview(infoNumberLabel)
        view.addSubview(lottoDatelabel)
        view.addSubview(dividerLine)
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
        
        roundPickerView.snp.makeConstraints { make in
            make.size.equalTo(roundTextField.snp.size)
        }
        
        infoNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(infoNumberLabel.snp.bottom).offset(8)
            make.height.equalTo(2)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        lottoDatelabel.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(dividerLine.snp.top)
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
            }
            
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
    
    @objc func getLottoInfo() {
        let lottoRound = round
        let url = LottoAPIKey.lottoURL + "\(lottoRound)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                self.roundLabel.text = "\(value.drwNo)회"
                self.lottoDatelabel.text = "\(value.drwNoDate)"
                self.numberlabel1.text = "\(value.drwtNo1)"
                self.numberlabel2.text = "\(value.drwtNo2)"
                self.numberlabel3.text = "\(value.drwtNo3)"
                self.numberlabel4.text = "\(value.drwtNo4)"
                self.numberlabel5.text = "\(value.drwtNo5)"
                self.numberlabel6.text = "\(value.drwtNo6)"
                self.numberlabel7.text = "\(value.bnusNo)"
                
            case.failure(let error):
                print(error)
                self.roundTextField.text = nil
                self.roundTextField.placeholder = "유효한 숫자만 입력해주세요"
            }
        }
    }
}

struct Lotto: Decodable {
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    let drwNoDate: String
}

//extension LottoViewController: UITextFieldDelegate {
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text = textField.text {
//            round = Int(text) ?? 0
//            getLottoInfo()
//        }
//    }
//}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lottoList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let lottoR = Int(lottoList[row]){
            print(lottoR)
            round = lottoR
            roundTextField.text = "\(lottoR)"
            getLottoInfo()
        }
    }
}
