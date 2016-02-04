//
//  QRCodeViewController.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit
import AVFoundation

class QRCodeViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    private var titleLabel = UILabel()
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var animationLineView = UIImageView()
    private var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildInputAVCaptureDevice()
        
        buildFrameImageView()
        
        buildTitleLabel()
        
        buildAnimationLineView()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    // MARK: - Build UI
    private func buildNavigationItem() {
        navigationItem.title = "店铺二维码"
        
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    private func buildTitleLabel() {
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.frame = CGRectMake(0, 340, ScreenWidth, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(titleLabel)
    }
    
    private func buildInputAVCaptureDevice() {
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        titleLabel.text = "将店铺二维码对准方块内既可收藏店铺"
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        if input == nil {
            titleLabel.text = "没有摄像头你描个蛋啊~换真机试试"
            
            return
        }
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession = AVCaptureSession()
        captureSession?.addInput(input!)
        captureSession?.addOutput(captureMetadataOutput)
        let dispatchQueue = dispatch_queue_create("myQueue", nil)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.frame
        view.layer.addSublayer(videoPreviewLayer!)
        captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1)
        
        captureSession?.startRunning()
    }
    
    private func buildFrameImageView() {
        
        let lineT = [CGRectMake(0, 0, ScreenWidth, 100),
            CGRectMake(0, 100, ScreenWidth * 0.2, ScreenWidth * 0.6),
            CGRectMake(0, 100 + ScreenWidth * 0.6, ScreenWidth, ScreenHeight - 100 - ScreenWidth * 0.6),
            CGRectMake(ScreenWidth * 0.8, 100, ScreenWidth * 0.2, ScreenWidth * 0.6)]
        for lineTFrame in lineT {
            buildTransparentView(lineTFrame)
        }
        
        let lineR = [CGRectMake(ScreenWidth * 0.2, 100, ScreenWidth * 0.6, 2),
            CGRectMake(ScreenWidth * 0.2, 100, 2, ScreenWidth * 0.6),
            CGRectMake(ScreenWidth * 0.8 - 2, 100, 2, ScreenWidth * 0.6),
            CGRectMake(ScreenWidth * 0.2, 100 + ScreenWidth * 0.6, ScreenWidth * 0.6, 2)]
        
        for lineFrame in lineR {
            buildLineView(lineFrame)
        }
        
        let yellowHeight: CGFloat = 4
        let yellowWidth: CGFloat = 30
        let yellowX: CGFloat = ScreenWidth * 0.2
        let bottomY: CGFloat = 100 + ScreenWidth * 0.6
        let lineY = [CGRectMake(yellowX, 100, yellowWidth, yellowHeight),
            CGRectMake(yellowX, 100, yellowHeight, yellowWidth),
            CGRectMake(ScreenWidth * 0.8 - yellowHeight, 100, yellowHeight, yellowWidth),
            CGRectMake(ScreenWidth * 0.8 - yellowWidth, 100, yellowWidth, yellowHeight),
            CGRectMake(yellowX, bottomY - yellowHeight + 2, yellowWidth, yellowHeight),
            CGRectMake(ScreenWidth * 0.8 - yellowWidth, bottomY - yellowHeight + 2, yellowWidth, yellowHeight),
            CGRectMake(yellowX, bottomY - yellowWidth, yellowHeight, yellowWidth),
            CGRectMake(ScreenWidth * 0.8 - yellowHeight, bottomY - yellowWidth, yellowHeight, yellowWidth)]
        
        for yellowRect in lineY {
            buildYellowLineView(yellowRect)
        }
    }
    
    private func buildLineView(frame: CGRect) {
        let view1 = UIView(frame: frame)
        view1.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        view.addSubview(view1)
    }
    
    private func buildYellowLineView(frame: CGRect) {
        let yellowView = UIView(frame: frame)
        yellowView.backgroundColor = LFBNavigationYellowColor
        view.addSubview(yellowView)
    }
    
    private func buildTransparentView(frame: CGRect) {
        let tView = UIView(frame: frame)
        tView.backgroundColor = UIColor.blackColor()
        tView.alpha = 0.5
        view.addSubview(tView)
    }
    
    private func buildAnimationLineView() {
        animationLineView.image = UIImage(named: "yellowlight")
        view.addSubview(animationLineView)
        
        timer = NSTimer(timeInterval: 2.5, target: self, selector: "startYellowViewAnimation", userInfo: nil, repeats: true)
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer!, forMode: NSRunLoopCommonModes)
        timer!.fire()
    }
    
    func startYellowViewAnimation() {
        weak var weakSelf = self
        animationLineView.frame = CGRectMake(ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, 100, ScreenWidth * 0.5, 20)
        UIView.animateWithDuration(2.5) { () -> Void in
            weakSelf!.animationLineView.frame.origin.y += ScreenWidth * 0.55
        }
    }
}
