
import UIKit
import AVFoundation
import SnapKit

class ScannerVC: UIViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Scanner"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    private let readerView = ReaderView()
    private lazy var readButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("STOP", for: .selected)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(scanButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        self.readerView.delegate = self
        
        self.readButton.layer.masksToBounds = true
        self.readButton.layer.cornerRadius = 15
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
    
    // TODO: IBAction
    @objc private func scanButton() {
        if self.readerView.isRunning {
            print("이즈낫러닝")
            self.readerView.stop(isButtonTap: true)
            readButton.isSelected = false
        } else {
            print("이즈러닝")
            self.readerView.start()
            readButton.isSelected = true
        }
    }
}

extension ScannerVC: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }

            title = "알림"
            message = "인식성공\n\(code)"
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                self.readButton.isSelected = readerView.isRunning
            } else {
                self.readButton.isSelected = readerView.isRunning
                return
            }
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ScannerVC {
    private func setLayout() {
        [headerLabel, readButton].forEach {
            self.view.addSubview($0)
        }
        self.view.addSubview(readerView)
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        readerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerLabel.snp.bottom).offset(30)
            $0.height.width.equalTo(314)
        }
        
        readButton.snp.makeConstraints {
            $0.top.equalTo(readerView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(200)
        }
    }
}
