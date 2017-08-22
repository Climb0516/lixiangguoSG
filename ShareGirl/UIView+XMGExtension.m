//
//  UIView+XMGExtension.m
//  Utopia
//
//  Created by 姜鸥人 on 16/5/20.
//  Copyright © 2016年 HeiCoder_OR. All rights reserved.
//

#import "UIView+XMGExtension.h"

@implementation UIView (XMGExtension)


-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{
    return self.frame.size;
}

-(void)setWidht:(CGFloat)wight{
    CGRect  frame = self.frame;
    frame.size.width =wight;
    self.frame =frame;
 }

-(void)setHeight:(CGFloat)height{
    CGRect  frame = self.frame;
    frame.size.height = height;
    self.frame =frame;
}

-(void)setX:(CGFloat)x{
    CGRect  frame = self.frame;
    frame.origin.x = x;
    self.frame =frame;
}
-(void)setY:(CGFloat)y{
    CGRect  frame = self.frame;
    frame.origin.y = y;
    self.frame =frame;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)widht{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)x{
    return self.frame.origin.x;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY{
    return self.center.y;
}
-(CGFloat)centerX{
    return self.center.x;
}
@end
