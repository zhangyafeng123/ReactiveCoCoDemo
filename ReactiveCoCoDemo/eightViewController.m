//
//  eightViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/26.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "eightViewController.h"
#import "Header.h"
#import "LoginViewModel.h"
@interface eightViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (nonatomic, strong) LoginViewModel *loginVM;
@end

@implementation eightViewController
- (LoginViewModel *)loginVM
{
    if (_loginVM == nil) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
    
    
    
    [self loginEvents];
    
}
/**
 绑定viewModel模型
 */
- (void)bindViewModel
{
    /**
     VM:最好不要包括视图
     */
    //1.给视图模型的账号和密码绑定信号
    //只要文本框内容发生改变，就会对其赋值
    RAC(self.loginVM,account) = _accountField.rac_textSignal;
    RAC(self.loginVM,pwd) = _pwdField.rac_textSignal;
}
/**
 处理业务逻辑
 */
- (void)loginEvents
{
    //设置按钮是否能点击
    RAC(_loginbtn,enabled) = self.loginVM.loginEnableSignal;
    
    
    [[_loginbtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了登录按钮");
        //处理登录事件
        [self.loginVM.loginCommand execute:nil];
    }];
}



@end
