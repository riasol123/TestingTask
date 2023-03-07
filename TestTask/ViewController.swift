import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref = Database.database().reference()
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = Constants.cornerRadius
        label.layer.borderWidth = 2
        label.layer.borderColor =  Colors.borderColor
        label.layer.backgroundColor = Colors.topColor
        label.textColor = Colors.textColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var parse: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.borderWidth = 2
        button.layer.borderColor =  Colors.borderColor
        button.layer.backgroundColor = Colors.topColor
        button.setTitle("Parse", for: .normal)
        button.setTitleColor(Colors.textColor, for: .normal)
        button.addTarget(self, action: #selector(dataParse), for: .touchUpInside)
        return button
    }()
    
    private lazy var show: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.borderWidth = 2
        button.layer.borderColor = Colors.borderColor
        button.layer.backgroundColor = Colors.topColor
        button.setTitle("Show", for: .normal)
        button.setTitleColor(Colors.textColor, for: .normal)
        button.addTarget(self, action: #selector(dataShow), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        setGradientBackground()
        
    }
    
    func setGradientBackground() {
        let colorTop =  Colors.topColor
        let colorBottom = Colors.bottomColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func layout() {
        view.addSubview(label)
        view.addSubview(parse)
        view.addSubview(show)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMarginLabel),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topMargin),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constants.sideMarginLabel),
            label.bottomAnchor.constraint(equalTo: label.topAnchor, constant: Constants.size),
            
            parse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMarginButton),
            parse.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.labelButtonSpace),
            view.trailingAnchor.constraint(equalTo: parse.trailingAnchor, constant: Constants.sideMarginButton),
            parse.bottomAnchor.constraint(equalTo: parse.topAnchor, constant: Constants.size),
            
            show.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMarginButton),
            show.topAnchor.constraint(equalTo: parse.bottomAnchor, constant: Constants.spaceBetweenButton),
            view.trailingAnchor.constraint(equalTo: show.trailingAnchor, constant: Constants.sideMarginButton),
            show.bottomAnchor.constraint(equalTo: show.topAnchor, constant: Constants.size)
        ])
    }
    
    

    @objc
    func dataParse() {
        
        var text = ""
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                let importData = try JSONDecoder().decode(Data.self, from: data)
                text = "\(importData.data.market_cap_percentage["btc"] ?? 0)"
                
                self.ref.child("btc").setValue(text)

            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    
    @objc
    func dataShow() {
        var btcValue = String()
        self.ref.child("btc").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            btcValue = snapshot?.value as? String ?? ""
            self.label.text = btcValue
        })
      
    }
    
    
}

