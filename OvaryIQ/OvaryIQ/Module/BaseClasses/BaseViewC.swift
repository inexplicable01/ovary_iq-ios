//
//  BaseViewC.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import UIKit

class BaseViewC: UIViewController {

    // MARK: - IBOutlets

    // MARK: - Properties

    // MARK: - View Life Cycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        dLog(message: "ClassStart :: \(String(describing: type(of: self)))")

        // Hide Navigation Bar
        self.navigationController?.navigationBar.isHidden = true

        // Remove Default Back Button
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = nil

        self.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dLog(message: "ClassStart :: \(String(describing: type(of: self)))")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        dLog(message: "ClassEnd :: \(String(describing: type(of: self)))")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        dLog(message: "ClassReleased :: \(String(describing: type(of: self)))")
    }

    // MARK: - Init Function

    // MARK: - Notifications Functions

    // MARK: - Private Functions

    private func initialSetup() {

    }

    // MARK: - Internal Functions

    // MARK: - Selectors Actions

    // MARK: - Button Actions
}

// MARK: - IBOutlets

// MARK: - Properties

// MARK: - View Life Cycle Functions

// MARK: - Init Function

// MARK: - Notifications Functions

// MARK: - Private Functions

// MARK: - Internal Functions

// MARK: - Selectors Actions

// MARK: - Button Actions

// MARK: - API Calls

// MARK: - UITextFieldDelegate

// MARK: - UITextViewDelegate

// MARK: - UIScrollViewDelegate

// MARK: - UITableViewDelegate, UITableViewDataSource

// MARK: - Any Table Cell Delegates

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

// MARK: - Any Collections Cell Delegates

// MARK: - Rest Event CallBacks Handler

// MARK: - Local Event CallBacks Handler
