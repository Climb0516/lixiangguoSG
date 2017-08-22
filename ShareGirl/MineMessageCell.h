//
//  MineMessageCell.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userMessage;
@property (strong, nonatomic) IBOutlet UIImageView *userState;
@end
