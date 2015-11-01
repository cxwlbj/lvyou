//
//  ProfileModel.h
//  lvyou
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface ProfileModel : BaseModel

/*
 "Items": {
 "Id": 168883,
 "Phone": "",
 "Uid": "e8c35cdb-6a93-11e5-99ba-00163e002e59",
 "Token": "e8c35d4a-6a93-11e5-99ba-00163e002e59",
 "Nickname": "浮生若梦_cf",
 "Status": 0,
 "Gender": "男",
 "Birthday": "",
 "Country": "",
 "Province": "",
 "City": "",
 "Email": "",
 "Age": 20,
 "Constellation": "",
 "Md5Uid": "0ad0cdcaf2e45528fdde7ee1457c92b3",
 "CreateTime": "2015-10-04T20:32:00+08:00",
 "Code": "",
 "WxUnionid": "",
 "QqOpenid": "",
 "SinaUid": "2997836375",
 "HeadUrl": "http://img2.miaotu.com/2015-10-04/45b4f49380b57d1057fbc576c10ae9e2.jpg",
 "PicUrl": "",
 "PhotoList": null,
 "AboutMe": "",
 "High": 0,
 "Education": "",
 "MaritalStatus": "单身求勾搭",
 "Address": "",
 "GraduateSchool": "",
 "Work": "",
 "Tags": "",
 "BodyType": "",
 "WantGo": "随便走走",
 "BeenGo": "",
 "Hobbies": "",
 "Film": "",
 "Music": "",
 "Book": "",
 "Food": "",
 "LifeArea": "",
 "WorkArea": "",
 "FreeTime": "",
 "Budget": "",
 "Home": "",
 "LikeCount": 0,
 "LikedCount": 0,
 "ActivityLikeCount": 0,
 "ActivityJoinCount": 0,
 "PhotoCount": 0,
 "YueyouLikeCount": 0,
 "YueyouJoinCount": 0,
 "IsLike": false,
 "LuckyMoney": 0,
 "OrderCount": 0,
 "CustomCount": 0
	}
 */

@property(nonatomic, copy)NSString *Id;
@property(nonatomic, copy)NSString *Token;
@property(nonatomic, copy)NSString *Nickname;
@property(nonatomic, copy)NSString *Gender;
@property(nonatomic, copy)NSString *Age;
@property(nonatomic, copy)NSString *SinaUid;
@property(nonatomic, copy)NSString *WxUnionid;
@property(nonatomic, copy)NSString *HeadUrl;
@property(nonatomic, copy)NSString *MaritalStatus;
@property(nonatomic, copy)NSString *WantGo;
@property(nonatomic, strong)NSNumber *LikeCount;
@property(nonatomic, strong)NSNumber *LikedCount;

@end
