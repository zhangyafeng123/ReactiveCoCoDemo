//
//  LoginViewModel.h
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/26.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
@interface LoginViewModel : NSObject

//保存登录界面的账号和密码
@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *pwd;


//处理登录按钮是否允许点击
@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;
/**
 登录按钮的命令
 */
@property (nonatomic, strong) RACCommand *loginCommand;



@end
