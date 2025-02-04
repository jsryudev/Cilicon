import Foundation

struct GitHubProvisionerConfig: Decodable {
    /// The GitHub API URL. Will be `https://api.github.com/` in most cases
    let apiURL: URL?
    /// The App Id of the installed application with Organization "Self-hosted runners" Read & Write access.
    let appId: Int
    /// The organization slug
    let organization: String
    /// Path to the private key `.pem` file downloaded from the Github App page
    let privateKeyPath: String
    /// Extra labels to add to the runner
    let extraLabels: [String]?
    
    enum CodingKeys: CodingKey {
        case apiURL
        case appId
        case organization
        case privateKeyPath
        case extraLabels
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.apiURL = try container.decodeIfPresent(URL.self, forKey: .apiURL)
        self.appId = try container.decode(Int.self, forKey: .appId)
        self.organization = try container.decode(String.self, forKey: .organization)
        self.privateKeyPath = (try container.decode(String.self, forKey: .privateKeyPath) as NSString).standardizingPath
        self.extraLabels = try container.decodeIfPresent([String].self, forKey: .extraLabels)
    }
}
