

import Foundation
import UIKit

struct Teammate: Codable {
    var name: String
    var star: String
    var interest: String
    var birth: String
    var innerBeauty: Bool
    var imageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(teammates: [Teammate]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(teammates) {
            let url = Teammate.documentsDirectory.appendingPathComponent("teammate")
            try? data.write(to: url)
        }
    }
    
    static func readTeammatesFromFile() -> [Teammate]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Teammate.documentsDirectory.appendingPathComponent("teammate")
        if let data = try? Data(contentsOf: url), let teammates = try? propertyDecoder.decode([Teammate].self, from: data) {
            return teammates
        } else {
            return nil
        }
    }
    
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Teammate.documentsDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            return  #imageLiteral(resourceName: "自己跟自己傳簡訊")
        }
    }
}

