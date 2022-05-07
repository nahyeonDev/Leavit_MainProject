//
//  ChatModeling.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/27.
//
class ChatModel{
    var name: String? //제목
    var title: String?  //시간
    
    init(name:String?, title:String?){
        self.title = title
        self.name = name
    }
}

class ChatModel2{
    var name: String? //제목
    var title: String?  //시간
    
    init(name:String?, title:String?){
        self.title = title
        self.name = name
    }
}

class ReChatModel{
    var title: String?
    var money: String?
    var time: String?
    
    init(title:String?, money:String?, time:String?){
        self.title = title
        self.money = money
        self.time = time
    }
}

class OfChatModel{
    var name: String?
    var loc: String?
    var time: String?
    
    init(name:String?, loc:String?, time:String?){
        self.name = name
        self.loc = loc
        self.time = time
    }
}
