//
//  AddressViewController.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/27.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()
@property (strong, nonatomic) IBOutlet UIPickerView *myPickerView;
// 背景图
@property (strong, nonatomic) IBOutlet UIView *PickerBgView;
// 省级
@property (strong, nonatomic) NSArray *provinceArray;
// 城市
@property (strong, nonatomic) NSArray *cityArray;
// 区县
@property (strong, nonatomic) NSArray *townArray;

@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *selectedArray;
@property (strong, nonatomic) UIView *maskView;

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation AddressViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加收货地址";
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(keepBtnAction)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    self.PickerBgView.widht =SCREEN_WIDTH;
    self.PickerBgView.height = 300;
      [self getPickerData];
}

-(void)keepBtnAction{
    NSLog(@"保存");
     NSString *str;
    ManagerType
    if (self.addDefault.selected == YES) {
        str = @"1";
    }else{
        str = @"0";
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *string = [user objectForKey:@"userID"];
    [dic setValue:string forKey:@"MemberId"];
    NSLog(@"%@",string);
    [dic setValue:self.addName.text forKey:@"Name"];
    [dic setValue:self.addPhone.text forKey:@"Mobile"];
    NSString *str1 = [self.addressOne.text stringByAppendingString:self.addContent.text];
    
    [dic setValue:str1 forKey:@"AddressDetails"]; // 详细地址
    [dic setValue:str forKey:@"IsDefault"];
    [dic setValue:@"101000" forKey:@"ZipCode"];
    NSString *httpUrl = [UrlString stringByAppendingString:@"/MemberAddressInterface/PostHandler.ashx"];
    [self.manager POST:httpUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *strr = [NSString stringWithFormat:@"%@",responseObject[@"Result"]];
        if ([strr  isEqual: @"1"]) {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setBool:YES forKey:@"isAddress"];
            [user setValue:responseObject[@"Message"] forKey:@"isAddressID"];
        }
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

-(void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dizhiquxiao:(id)sender {
     [ self hideMyPicker];
}
- (IBAction)dizhiquedign:(id)sender {
    self.addressOne.text = [NSString stringWithFormat:@"%@-%@-%@",[self.provinceArray objectAtIndex:[self.myPickerView selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.myPickerView selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.myPickerView selectedRowInComponent:2]]];
    [self hideMyPicker];

}

- (IBAction)AddChouseDafate:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
}
- (IBAction)AddressChouse:(UIButton *)sender {
    NSLog(@"选择地址");
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.PickerBgView];
    self.maskView.alpha = 0;
    self.PickerBgView.top = self.maskView.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.PickerBgView.bottom = self.maskView.height;
    }];
}
-(void)getPickerData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path]; // 获取字典
    self.provinceArray = [self.pickerDic allKeys]; // 一级数据(省
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}
- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.PickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.PickerBgView removeFromSuperview];
    }];
}
//回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
