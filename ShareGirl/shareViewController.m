//
//  shareViewController.m
//  Utopia
//
//  Created by 姜鸥人 on 16/8/5.
//  Copyright © 2016年 HeiCoder_OR. All rights reserved.
//

#import "shareViewController.h"

@interface shareViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userName;
// 邀请码
@property (strong, nonatomic) IBOutlet UILabel *yaoqingNumber;
// 二维码
@property (strong, nonatomic) IBOutlet UIImageView *weWeiMa;

@end

@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"邀请好友";

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
       
//    self.userName.text =[NSString stringWithFormat:@"昵称:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
//    self.yaoqingNumber.text = [NSString stringWithFormat:@"邀请码:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"]];
      NSString *httpUrl = @"http://59.110.48.164:8001/Images/ShareImg/iosShare.jpg";
    [self.weWeiMa sd_setImageWithURL:[NSURL URLWithString:httpUrl]];
    
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//host:1508/share.html?LoginName=aaa&Mobile=123&PlatForm=ios
//-(void)fenxiangAction{
//    NSString *stringName =[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
//    NSString *stringNumber =[[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
//     NSString *httpUrl = [UrlString stringByAppendingString:@"/share.html?LoginName=%@&Mobile=%@&PlatForm=ios"];
//    NSString*stringURL = [NSString stringWithFormat:httpUrl,stringName,stringNumber];
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = stringURL;
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"%@邀请您加入理想国!",stringName];
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title =[NSString stringWithFormat:@"%@邀请您加入理想国!验证码为%@",stringName,stringNumber];
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = stringURL;
//    // 微信纯图片
////    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
//    [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = self.weWeiMa.image;
//    
//    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = @"http://baidu.com";
//    NSString *string = [NSString stringWithFormat:@"%@的邀请码是:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"]];
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57c8fa0267e58e127b00113e"
//                                      shareText:string
//                                     shareImage:self.weWeiMa.image
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]
//                                       delegate:self];
//}
//
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的平台名
//        //(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}
//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
