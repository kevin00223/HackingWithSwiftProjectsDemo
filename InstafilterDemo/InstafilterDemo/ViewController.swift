//
//  ViewController.swift
//  InstafilterDemo
//
//  Created by 李凯 on 2019/4/9.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var intensity: UISlider!
    
    // user selected image
    var currentImage: UIImage!
    
    // a component from CoreImage that handles rendering
    var context: CIContext!
    
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        prepareNavigationBar()
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    func prepareNavigationBar() {
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    func applyProcessing() {
        
        // 0. 设置key值
        let inputKeys = currentFilter.inputKeys
        // 1. 将slider的值设置给当前渲染器
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width * 0.5, y: currentImage.size.height * 0.5), forKey: kCIInputCenterKey)
        }
        // 2. 从currentFilter中获取图片
        guard let image = currentFilter.outputImage else { return }
        // 3. 将图片放到context中渲染 并设置给imageView
        if let cgimg = context.createCGImage(image, from: image.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
    
    @objc func importPicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func intensityChanged(_ sender: UISlider) {
        // called whenever the slider is moved
        applyProcessing()
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        //1. 拿到图片
        guard let image = imageView.image else { return }
        //2. 保存图片到相册 (其中selector的格式是文档规定好的)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Saved", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func setFilter(action: UIAlertAction) {
        // 保证当前有图片可供渲染 (!!!guard与if语句功能相同!!!)
        guard currentImage != nil else { return }
        
        guard let actionTitle = action.title else { return }
        
        //1. 设置渲染方式
        currentFilter = CIFilter(name: actionTitle)
        //2. 获取要渲染的图片 并设置给渲染器
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //3. 执行渲染
        applyProcessing()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true, completion: nil)
        
        currentImage = image
        
        // 将选中的image转成CIImage
        let beginImage = CIImage(image: currentImage)
        // 将图片添加到currentFilter中
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        // called as soon as the image is first imported
        applyProcessing()
    }
}

