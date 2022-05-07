//
//  DetailModel.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/02.
//

class DetailModel{
    var title: String? //제목
    var method: String? //지급방법
    var money: String? //돈
    var day: String? //요일
    var time: String? //시간
    var detail: String?  //세부글
    var url: String? //url
    var job: String? //업직종
    var career: String? //경력
    var certif: String? //자격증
    var tag1: String?  //태그
    var tag2: String?
    var tag3: String?
    
    init(title:String?, method:String?, money:String?, day:String?,  time:String?, detail:String?, url:String?, job:String?, career:String?, certif:String?, tag1:String?, tag2:String?, tag3:String?){
        
        self.title = title
        self.method = method
        self.money = money
        self.day = day
        self.time = time
        self.detail = detail
        self.url = url
        self.job = job
        self.career = career
        self.certif = certif
        self.tag1 = tag1
        self.tag2 = tag2
        self.tag3 = tag3
    }
}

class DetailModel2{
    var name: String? //이름
    var job: String? //업직종
    var gen: String? //성별,나이
    var loc: String? //위치
    var day: String? //요일
    var time: String? //시간
    var detail: String?  //세부글
    var career: String? //경력
    var certif: String? //자격증
    var tag1: String?  //태그
    var tag2: String?
    var tag3: String?
    
    init(name:String?, job:String?, gen:String?, loc:String?, day:String?,  time:String?, detail:String?, career:String?, certif:String?, tag1:String?, tag2:String?, tag3:String?){
        
        self.name = name
        self.job = job
        self.gen = gen
        self.loc = loc
        self.day = day
        self.time = time
        self.detail = detail
        self.career = career
        self.certif = certif
        self.tag1 = tag1
        self.tag2 = tag2
        self.tag3 = tag3
    }
}
