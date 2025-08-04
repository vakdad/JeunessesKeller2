import SwiftUI
import UIKit
import MessageUI

struct ShareFileButton: UIViewControllerRepresentable {
    let fileName: String

    func makeCoordinator() -> Coordinator {
        Coordinator(fileName: fileName)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let button = UIButton(type: .system)
        button.setTitle("Email Transactions File", for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)

        button.addTarget(context.coordinator, action: #selector(Coordinator.emailFile), for: .touchUpInside)

        let vc = UIViewController()
        vc.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: vc.view.topAnchor)
        ])
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let fileName: String

        init(fileName: String) {
            self.fileName = fileName
        }

        @objc func emailFile() {
            guard MFMailComposeViewController.canSendMail(),
                  let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName),
                  let data = try? Data(contentsOf: url) else { return }
print(data)
            let mail = MFMailComposeViewController()
            mail.setSubject("Transactions Report")
            mail.setMessageBody("Attached is the transaction report.", isHTML: false)
            mail.addAttachmentData(data, mimeType: "text/tab-separated-values", fileName: fileName)
            mail.mailComposeDelegate = self

            if let root = UIApplication.shared.windows.first?.rootViewController {
                root.present(mail, animated: true)
            }
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}
