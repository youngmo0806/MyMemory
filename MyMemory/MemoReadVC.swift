//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by youngmo on 2021/06/09.
//

import UIKit

class MemoReadVC: UIViewController {

    var param: MemoData?
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1. 제목과 내용, 이미지를 출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        //2. 날짜 포맷 변환
        let formeter = DateFormatter()
        formeter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formeter.string(from: (param?.regdate)!)
        
        //3. 네비게이션 바에 날짜 표시
        self.navigationItem.title = dateString

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
