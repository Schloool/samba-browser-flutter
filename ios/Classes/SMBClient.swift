
import AMSMB2

class SMBClient {
    /// connect to: `smb://guest@XXX.XXX.XX.XX/share`
    
    let serverURL: URL
    let credential: URLCredential
    let share: String
    
    lazy private var client = AMSMB2(url: self.serverURL, credential: self.credential)!
    
    init(url: String, share: String, user: String, password: String) {
        serverURL = URL(string: url)!
        self.share = share
        credential = URLCredential(user: user, password: password, persistence: URLCredential.Persistence.forSession)
    }
    
    private func connect(handler: @escaping (Result<AMSMB2, Error>) -> Void) {
        // AMSMB2 can handle queueing connection requests
        client.connectShare(name: self.share) { error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(self.client))
            }
        }
    }
    
    func listDirectory(path: String) {
        connect { result in
            switch result {
            case .success(let client):
                client.contentsOfDirectory(atPath: path) { result in
                    switch result {
                    case .success(let files):
                        for entry in files {
                            print("name:", entry[.nameKey] as! String,
                                  ", path:", entry[.pathKey] as! String,
                                  ", type:", entry[.fileResourceTypeKey] as! URLFileResourceType,
                                  ", size:", entry[.fileSizeKey] as! Int64,
                                  ", modified:", entry[.contentModificationDateKey] as! Date,
                                  ", created:", entry[.creationDateKey] as! Date)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
