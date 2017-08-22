//
//  TeamModel.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/7.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamModel : NSObject

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Name;

@property(nonatomic,strong)NSString *LoginName;

@property(nonatomic,strong)NSString *LoginPwd;

@property(nonatomic,strong)NSString *PayPassword;

@property(nonatomic,strong)NSString *Gender;

@property(nonatomic,strong)NSString *Age;

@property(nonatomic,strong)NSString *LicenceNo;

@property(nonatomic,strong)NSString *Email;

@property(nonatomic,strong)NSString *Mobile;

@property(nonatomic,strong)NSString *CountyId;

@property(nonatomic,strong)NSString *Address;

@property(nonatomic,strong)NSString *Grade;

@property(nonatomic,strong)NSString *ParentId;

@property(nonatomic,strong)NSString *CreateTime;


@end
