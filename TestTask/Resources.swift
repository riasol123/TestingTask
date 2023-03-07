import UIKit

let screenSize: CGRect = UIScreen.main.bounds

struct Data: Codable {
    let data: Model
}

struct Model: Codable {
    let market_cap_percentage:[String: Double]
}

enum Constants {
    static var size = CGFloat(screenSize.height/13)
    static var topMargin = CGFloat(screenSize.height/3)
    static var sideMarginLabel = CGFloat(screenSize.width/6)
    static var labelButtonSpace = CGFloat(screenSize.height/13)
    static var spaceBetweenButton = CGFloat(screenSize.height/40)
    static var sideMarginButton = CGFloat(screenSize.width/3)
    static var cornerRadius = CGFloat(screenSize.height/26)
}

enum Colors {
    static var topColor = UIColor(red: 255.0/255.0, green: 250.0/255.0, blue: 225.0/255.0, alpha: 1.0).cgColor
    static var bottomColor = UIColor(red: 213.0/255.0, green: 231.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
    static var borderColor = UIColor(red: 167.0/255.0, green: 190.0/255.0, blue: 138.0/255.0, alpha: 1.0).cgColor
    static var textColor = UIColor(red: 92.0/255.0, green: 105.0/255.0, blue: 76.0/255.0, alpha: 1.0)
}
