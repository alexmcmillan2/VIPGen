//
//  FileContents.swift
//  modulegen
//
//  Created by Alex McMillan on 06/03/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

struct FileContents {
    static let viewControllerText: String = """
import UIKit

protocol GenericViewOutput: class {
    var data: [String] { get }
    func viewIsReady()
}

protocol GenericViewInput: class {
    func newDataAvailable()
}

class GenericTableViewController: UIViewController {

    private var viewOutput: GenericViewOutput!

    init(viewOutput: GenericViewOutput = GenericInteractor()) {
        self.viewOutput = viewOutput
        super.init(nibName: "GenericTableViewController", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: "GenericTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GenericTableViewCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput.viewIsReady()
    }
}

extension GenericTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewOutput.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! GenericTableViewCell
        cell.textLabel?.text = viewOutput.data[indexPath.row]
        return cell
    }
}

"""

    static let xibContents: String = """
<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="15400" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <device id="retina6_1" orientation="portrait" appearance="light"/>
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="15404"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="GenericTableViewController" customModule="" customModuleProvider="target">
            <connections>
                <outlet property="tableView" destination="ZWb-gd-KC5" id="kev-TG-QAU"/>
                <outlet property="view" destination="i5M-Pr-FkT" id="sfx-zR-JGt"/>
            </connections>
        </placeholder>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <view clearsContextBeforeDrawing="NO" contentMode="scaleToFill" id="i5M-Pr-FkT">
            <rect key="frame" x="0.0" y="0.0" width="414" height="896"/>
            <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
            <subviews>
                <tableView clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" style="plain" separatorStyle="default" rowHeight="-1" estimatedRowHeight="-1" sectionHeaderHeight="28" sectionFooterHeight="28" translatesAutoresizingMaskIntoConstraints="NO" id="ZWb-gd-KC5">
                    <rect key="frame" x="0.0" y="44" width="414" height="818"/>
                    <color key="backgroundColor" systemColor="systemBackgroundColor" cocoaTouchSystemColor="whiteColor"/>
                </tableView>
            </subviews>
            <color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
            <constraints>
                <constraint firstItem="fnl-2z-Ty3" firstAttribute="trailing" secondItem="ZWb-gd-KC5" secondAttribute="trailing" id="FDD-AT-Xcd"/>
                <constraint firstItem="fnl-2z-Ty3" firstAttribute="bottom" secondItem="ZWb-gd-KC5" secondAttribute="bottom" id="UUS-87-sTI"/>
                <constraint firstItem="ZWb-gd-KC5" firstAttribute="top" secondItem="fnl-2z-Ty3" secondAttribute="top" id="cf9-3Y-uV9"/>
                <constraint firstItem="ZWb-gd-KC5" firstAttribute="leading" secondItem="fnl-2z-Ty3" secondAttribute="leading" id="gII-DH-2CP"/>
            </constraints>
            <viewLayoutGuide key="safeArea" id="fnl-2z-Ty3"/>
            <point key="canvasLocation" x="-310" y="14"/>
        </view>
    </objects>
</document>

"""

    static let presenterText: String = """
import Foundation

protocol GenericPresentation {
    func makeDisplayItems(from response: [String]) -> [String]
}

class GenericPresenter: GenericPresentation {

    func makeDisplayItems(from response: [String]) -> [String] {
        return response
    }
}

"""

    static let interactorText: String = """
import Foundation

class GenericInteractor: GenericViewOutput {

    weak var viewInput: GenericViewInput?

    var data: [String] = []
    private let presenter: GenericPresentation

    init(presenter: GenericPresentation = GenericPresenter()) {
        self.presenter = presenter
    }

    func viewIsReady() {
        let response: [String] = []
        data = presenter.makeDisplayItems(from: response)
        viewInput?.newDataAvailable()
    }
}

"""

    static let cellText: String = """
import UIKit

class GenericTableViewCell: UITableViewCell {

}

"""

    static let cellXibText: String = """
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <tableViewCell contentMode="scaleToFill" selectionStyle="default" indentationWidth="10" id="KGk-i7-Jjw" customClass="GenericTableViewCell" customModuleProvider="target">
            <rect key="frame" x="0.0" y="0.0" width="320" height="44"/>
            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
            <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" tableViewCell="KGk-i7-Jjw" id="H2p-sc-9uM">
                <rect key="frame" x="0.0" y="0.0" width="320" height="43"/>
                <autoresizingMask key="autoresizingMask"/>
            </tableViewCellContentView>
            <viewLayoutGuide key="safeArea" id="njF-e1-oar"/>
        </tableViewCell>
    </objects>
</document>

"""
}
