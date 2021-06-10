//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by youngmo on 2021/06/09.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contents.delegate = self

    }
    
    
    // MARK: - Action
    @IBAction func save(_ sender: Any) {
        //1. 내용을 입력하지 않았을 경우, 경고 한다.
        guard self.contents.text.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //2. MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        //3. 앱 델리게이트 객체를 읽어온 다음, memoList 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        //4. 작성폼을 종료하고, 이전 화면으로 돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        //이미지 피커 화면을 표시한다.
        self.present(picker, animated: false, completion: nil)
    }
    
    // MARK: - UIImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 미리보기에 표시한다.
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        //이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        //내용의 최대 15자리를 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //네비게이션 타이틀에 표시한다.
        self.navigationItem.title = subject
    }
}
