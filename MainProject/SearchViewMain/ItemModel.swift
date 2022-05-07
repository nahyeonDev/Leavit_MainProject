//
//  ItemModel.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/02.
//

class ItemModel{
    var title: String? //제목
    var time: String?  //시간
    var money: String? //돈
    var tag1: String?  //태그1
    var tag2: String?  //태그2
    var tag3: String?  //태그3
    
    init(title:String?, time:String?, money:String?, tag1:String?, tag2:String?, tag3:String?){
        self.title = title
        self.time = time
        self.money = money
        self.tag1 = tag1
        self.tag2 = tag2
        self.tag3 = tag3
    }
}

class ItemModel2{
    var name: String? //이름
    var genNum: String? //성별나이
    var tag1: String? //태그1
    var tag2: String? //태그2
    var tag3: String? //태그3
    
    init(name:String?, genNum:String?, tag1:String?, tag2:String?, tag3:String?){
        self.name = name
        self.genNum = genNum
        self.tag1 = tag1
        self.tag2 = tag2
        self.tag3 = tag3
    }
}

class UserModel{
    var uid: String?
    
    init(uid:String?){
        self.uid = uid
    }
}

class UserModel2{
    var uid2: String?
    
    init(uid2:String?){
        self.uid2 = uid2
    }
}
