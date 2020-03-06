import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!

    @IBAction func tappedButton(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseDirectories = true
        dialog.beginSheetModal(for: self.view.window!) { result in
            if result == .OK, let url = dialog.url {
                let moduleName = self.textField.stringValue

                let viewControllerText = FileContents.viewControllerText.replacingOccurrences(of: "Generic", with: moduleName)
                let xibText = FileContents.xibContents.replacingOccurrences(of: "Generic", with: moduleName)
                let cellText = FileContents.cellText.replacingOccurrences(of: "Generic", with: moduleName)
                let cellXibText = FileContents.cellXibText.replacingOccurrences(of: "Generic", with: moduleName)
                let presenterText = FileContents.presenterText.replacingOccurrences(of: "Generic", with: moduleName)
                let interactorText = FileContents.interactorText.replacingOccurrences(of: "Generic", with: moduleName)

                let viewControllerUrl = url.appendingPathComponent("\(moduleName)Module/View/\(moduleName)TableViewController.swift")
                let viewControllerXibUrl = url.appendingPathComponent("\(moduleName)Module/View/\(moduleName)TableViewController.xib")
                let cellUrl = url.appendingPathComponent("\(moduleName)Module/View/\(moduleName)TableViewCell.swift")
                let cellXibUrl = url.appendingPathComponent("\(moduleName)Module/View/\(moduleName)TableViewCell.xib")
                let presenterUrl = url.appendingPathComponent("\(moduleName)Module/Presentation/\(moduleName)Presenter.swift")
                let interactorUrl = url.appendingPathComponent("\(moduleName)Module/Interactor/\(moduleName)Interactor.swift")

                do {
                    let moduleFolderUrl = url.appendingPathComponent("\(moduleName)Module")
                    try FileManager.default.createDirectory(at: moduleFolderUrl, withIntermediateDirectories: false, attributes: nil)
                    try FileManager.default.createDirectory(at: moduleFolderUrl.appendingPathComponent("View"), withIntermediateDirectories: false, attributes: nil)
                    try FileManager.default.createDirectory(at: moduleFolderUrl.appendingPathComponent("Interactor"), withIntermediateDirectories: false, attributes: nil)
                    try FileManager.default.createDirectory(at: moduleFolderUrl.appendingPathComponent("Presentation"), withIntermediateDirectories: false, attributes: nil)

                    try viewControllerText.write(to: viewControllerUrl, atomically: true, encoding: .utf8)
                    try xibText.write(to: viewControllerXibUrl, atomically: true, encoding: .utf8)
                    try cellText.write(to: cellUrl, atomically: true, encoding: .utf8)
                    try cellXibText.write(to: cellXibUrl, atomically: true, encoding: .utf8)
                    try interactorText.write(to: interactorUrl, atomically: true, encoding: .utf8)
                    try presenterText.write(to: presenterUrl, atomically: true, encoding: .utf8)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

}
