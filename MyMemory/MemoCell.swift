//
//  MemoCell.swift
//  MyMemory
//
//  Created by youngmo on 2021/06/09.
//

import UIKit

class MemoCell: UITableViewCell {

    @IBOutlet weak var subject: UILabel!    //제목
    @IBOutlet weak var contents: UILabel!   //내용
    @IBOutlet weak var regdate: UILabel!    //등록일자
    @IBOutlet weak var img: UIImageView!    //이미지
}
