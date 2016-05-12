//
//  MIACommentModel.h
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIACommentModel : NSObject

@property (nonatomic, copy) NSString *itemID;//
@property (nonatomic, copy) NSString *addtime;//评论创建的时间
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *id;//id
@property (nonatomic, copy) NSString *nick;//评论人的名字
@property (nonatomic, copy) NSString *pID;//
@property (nonatomic, copy) NSString *status;//
@property (nonatomic, copy) NSString *uID;//
@property (nonatomic, copy) NSString *userpic;//评论人的图片
@property (nonatomic, copy) NSString *itemType;//评论的类型A


//@property(nonatomic, strong)  NSString *ID;
//@property(nonatomic, strong)  NSString *uID;
//@property(nonatomic, strong)  NSString *nickName;
//@property(nonatomic, strong)  NSString *avatarUrl;
//@property(nonatomic, strong)  NSString *content;
//
//@property(nonatomic, assign) NSInteger  createDate;

@property(nonatomic, strong)  NSString *date;

@end
