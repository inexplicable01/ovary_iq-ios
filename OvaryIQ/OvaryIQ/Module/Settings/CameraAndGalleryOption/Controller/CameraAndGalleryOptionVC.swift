//
//  CameraAndGalleryOptionVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 07/03/22.
//

import UIKit
protocol CameraAndGalleryOptionVCDelegate {
    func selectedImageFromCameraAndAlbum(selectedImg: UIImage)
}

class CameraAndGalleryOptionVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var btnCancel: UIButton!
    // MARK: - Properties
    private var imagePicker = UIImagePickerController()
    internal var delegate: CameraAndGalleryOptionVCDelegate?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        //self.viewModel.registerCoreEngineEventsCallBack()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.viewModel.registerCoreEngineEventsCallBack()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.viewModel.unregisterCoreEngineEventsCallBack()
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
       // self.viewModel.unregisterCoreEngineEventsCallBack()
       classReleased()
    }

    // MARK: - Notifications Functions

    // MARK: - Private Functions
    private func initialSetup() {
        self.btnCancel.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        imagePicker.delegate = self
       // self.viewModel.delegate = self
    }
    //MARK: - Images Picker From Gallery
   private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            self.present(imagePicker, animated: true, completion: nil)

        }else{
            let alert = UIAlertController()
            alert.title = "You don't have gallary"

            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }

    }
    //MARK: - Images Picker From Camera
    private  func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController()
            alert.title = "You don't have camera"

            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Button Actions

    @IBAction private func tapBtnAlbum(_ sender: Any) {
        fLog()
        self.openGallery()
    }
    @IBAction private func tapBtnCancel(_ sender: Any) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func tapBtnCamera(_ sender: Any) {
        fLog()
        self.openCamera()
    }

}

//MARK:- UIImagePicker Delegate and dataSource Method
extension CameraAndGalleryOptionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            print("orifinal image...\(img)")
            picker.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true) {
                self.delegate?.selectedImageFromCameraAndAlbum(selectedImg: img)

            }
        }

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
