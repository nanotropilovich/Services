import Foundation

struct ResponseData: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}

struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let iconURL: String
    enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
