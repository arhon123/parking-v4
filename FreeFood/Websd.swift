//
//  Websd.swift
//  Parking
//
//  Created by D7703_14 on 2017. 12. 7..
//  Copyright © 2017년 박지훈. All rights reserved.
//

import UIKit

class Websd: UIViewController {

    @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: "https://map.naver.com/?query=%EB%B6%80%EC%82%B0+%EA%B3%B5%EC%98%81%EC%A3%BC%EC%B0%A8%EC%9E%A5&type=SITE_1")
        
        let request = NSURLRequest(url: url! as URL)
        webview.loadRequest(request as URLRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
