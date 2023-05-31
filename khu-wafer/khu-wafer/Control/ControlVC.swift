//
//  ControlVC.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/05/30.
//

import UIKit

class ControlVC: UIViewController {
    // MARK: - Components
    let areaCVHeight:CGFloat = 250
    private let headerLabel: UILabel = {
       let lb = UILabel()
        lb.text = "Robot Control"
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 26)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var areaCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 52
        let sideInset: CGFloat = 50
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - sideInset*2 - layout.minimumInteritemSpacing) / 2, height: (areaCVHeight - 20 - layout.minimumLineSpacing*2) / 3 )
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 10, left: sideInset, bottom: 10, right: sideInset)
        cv.isScrollEnabled = false
        return cv
    }()
    
    // MARK: - Properties
    private var webSocket: URLSessionWebSocketTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setCV()
        setLayout()
        setWebSocket()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        close()
    }
    
    private func setWebSocket() {
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        let url = URL(string: "wss://socketsbay.com/wss/v2/1/demo/")
        if let url = url {
            webSocket = session.webSocketTask(with: url)
        }
        webSocket?.resume()
    }
    
    private func setCV() {
        areaCV.dataSource = self
        areaCV.delegate = self
        areaCV.register(ControlCVC.self, forCellWithReuseIdentifier: "ControlCVC")
    }

}

extension ControlVC: URLSessionWebSocketDelegate {

    func ping() {
        webSocket?.sendPing { error in
            if let error = error {
                print("Ping error:\(error)")
            }
        }
    }
    
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "Demo ended".data(using: .utf8))
    }
    func send(index: Int = 0) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//              self.send()
              self.webSocket?.send(.string("Send Index: \(index)"), completionHandler: { error in
                  if let error = error {
                      print("Send error: \(error)")
                  }
                  
              })
          }
          
      }
    
    func receive() {
        
        webSocket?.receive(completionHandler: { [weak self] result in
            
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Got data: \(data)")
                case .string(let message):
                    print("Got string!: \(message)")
                @unknown default:
                    break
                }
            case .failure(let error):
                print("Receive error: \(error)")
            }
            
            self?.receive()
        })
        
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Did connect to socket")
        ping()
        receive()
        send()
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Did close connection with reason")
    }
}

extension ControlVC: UICollectionViewDelegateFlowLayout {
    
}

extension ControlVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ControlCVC", for: indexPath) as? ControlCVC else { return UICollectionViewCell() }
        cell.setCellTitle(num: indexPath.row + 1)
        return cell
    }
    
    
}



extension ControlVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelect \(indexPath)")
        self.send(index: indexPath.row + 1)
    }
}

extension ControlVC {
    private func setLayout() {
        [headerLabel, areaCV].forEach {
            self.view.addSubview($0)
        }
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 135).isActive = true
        
        areaCV.translatesAutoresizingMaskIntoConstraints = false
        areaCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        areaCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        areaCV.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 90).isActive = true
//        areaCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        areaCV.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        areaCV.heightAnchor.constraint(equalToConstant: areaCVHeight).isActive = true
    }
}
