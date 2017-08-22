//
//  HomeImageModel.h
//  V-show
//
//  Created by 姜鸥人 on 2017/7/17.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeImageModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *ImageUrl;
@property(nonatomic,strong)NSString *State;
@property(nonatomic,strong)NSString *CreateTime;
@property(nonatomic,strong)NSString *ModelId;
@property(nonatomic,strong)NSString *TypeId;
@property(nonatomic,strong)NSString *Keywords;
@property(nonatomic,strong)NSString *Description;
@property(nonatomic,strong)NSArray *Title;
@end
