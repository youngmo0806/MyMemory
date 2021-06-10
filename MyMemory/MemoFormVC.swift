//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by youngmo on 2021/06/09.
//

import UIKit

class MemoFormVC: UIViewController, UITextViewDelegate {
    
    var subject: String!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.allowsEditing = true
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
        
        let alert = UIAlertController(title: "", message: "이미지를 가져올곳을 선택해 주세요", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "카메라", style: .default) { _ in
            print("카메라 선택")
            self.picker.sourceType = .camera
            self.present(self.picker, animated: false, completion: nil)
        }
        
        let saveAlbum  = UIAlertAction(title: "저장앨범", style: .default) { _ in
            print("저장앨범선택")
            self.picker.sourceType = .savedPhotosAlbum
            self.present(self.picker, animated: false, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(saveAlbum)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
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

extension MemoFormVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
