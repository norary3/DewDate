//
//  ActionViewController.swift
//  AutoEventAddActionExt
//
//  Created by cscoi027 on 2016. 8. 18..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    var convertingString: String?
    @IBOutlet weak var sampleTextView: UITextView!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        /*
         모든 익스텐션 뷰 컨트롤러는 NSExtensionContext 클래스의 인스턴스 형태로 연결된 익스텐션 콘텍스트(extension context)를 갖는다. 익스텐션 콘텍스트의 참조체는 뷰 컨트롤러의 extensionContext 속성을 통해 접근할 수 있다. 익스텐션 콘텍스트는 객체들을 포함하고 있는 배열의 형태인 inputi
         */
        // 각각의 NSExtensionItem객체는 attachment객체들의 배열을 갖는다. attachment객체는 NSItemProvider 타입이며, 호스트앱의 데이터에 접근할 수 있다. attachment객체의 참조체를 얻었으면 익스텐션이 지원하는 타입의 데이터를 호스트 애플리케이션이 가지고 있는지 검증하기 위하여 attachment 객체의 hasItemConformingToTypeIdentifier 메서드를 호출할 수 있다.
        let textItem: NSExtensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        // 핸들러 지정(string이라는 이름의 NSSecureCoding 변수와 error라는 이름의 NSError변수를 전달받아 처리하는 익명함수 선언)
        let handlerCompletion: (NSSecureCoding?, NSError)->Void = { string, error in
            // 핸들러 매개변수로 전달받은 변수를 String형태로 형변환하여 저장
            self.convertingString = string as? String
            print("HandlerCompletion ==> convertingString : \(self.convertingString)")
            if let parsingString = self.convertingString {
                // 전달받은 텍스트 데이터를 Parsing
                /* 전달 받는 텍스트 예시
                 제목:놀이공원 데이트
                 위치:롯데월드
                 시작:2016년 8월 20일 10:00
                 종료:2016년 8월 20일 17:00
                */
                let lines = parsingString.componentsSeparatedByString("\n")
                for line in lines {
                    print (line)
                    print ("row")
                }
                var title:String = ""
                var locaiton = ""
                var start = ""
                var end = ""
                
                
                // 메인스레드를 통하여 화면의 TextView에 갱신처리
                dispatch_async(dispatch_get_main_queue()){
                    self.sampleTextView.text = parsingString
                    self.titleTextField.text = title
                    self.locationTextField.text = locaiton
                    self.startTextField.text = start
                    self.endTextField.text = end
                }
            }
        }
        // 호스트 앱이 원하고자 하는 타입의 데이터를 가지고 있다면 익스텐션이 지원하는 UTI 컨텐츠 타입인자로 다시 전달되는 loadItemForTypeIdentifier 메서드 호출을 통하여 그 데이터가 익스텐션에 로드될수 있다. 호스트앱의 데이터를 로딩하는 것은 비동기적으로 수행하므로 데이터 로딩 과정이 완료될때 호출되는 완료 핸들러를 지정해야 한다.
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as NSString as String) {
            textItemProvider.loadItemForTypeIdentifier(
                kUTTypeText as String,      // 텍스트 타입의 데이터를 수신할 것으로 지정
                options: nil,
                // viewDidLoad에 선언한 handlerCompletion 변수를 통하여 핸들러를 지정하여 처리하도록 전달한다.
                // Swift 2.0에서는 unsafeBitCast함수를 이용하도록 변경되었다.
                completionHandler: unsafeBitCast(handlerCompletion, NSItemProviderCompletionHandler.self)
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }
    */
    
    /*
    @IBAction func add(sender: AnyObject) {
    }
    */
    
    
    @IBAction func cancel(sender: AnyObject) {
        // 이 함수는 입력 아이템을 unpacking하는 과정을 반대로 한다. 첫번째로 수정된 컨텐츠(convertedString)와 컨텐츠 타입 식별자(여기서는 kUTTypeText)로 구성한 새로운 NSItemProvider인스턴스를 생성한다.
        let returnProvider = NSItemProvider(item:convertingString, typeIdentifier: kUTTypeText as NSString as String)
        // 새로운 NSExtensionItem인스턴스를 생성하고 NSItemProvider 객체를 attachments에 할당한다.(호스트 앱으로 다시 전달하기 위하여 갱신된 정보를 저장)
        let returnItem = NSExtensionItem()
        returnItem.attachments = [returnProvider]
        
        // 익스텐션 콘텍스트의 completeRequestReturningItems 메서드에 NSExtensionItem 인스턴스를 인자로 전달하며 호출
        extensionContext!.completeRequestReturningItems([returnItem], completionHandler: nil)
    }

}
