//
//  LoginViewModel.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/26.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel


- (instancetype)init
{
    if ([super init]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    //处理登录点击的信号
    /**
     RACObserve(self, account)
     只要对象中的属性发生改变，就会产生一个信号
     */
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id (NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    //处理登录的点击命令
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //只要block执行命令就会调用
        //block作用：事件处理
        //发送登录请求
        NSLog(@"发送登录请求");
        
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //发送数据
                [subscriber sendNext:@"请求登录的数据"];
                //发送完成
                [subscriber sendCompleted];
            });
            
            
            return nil;
        }];
    }];
    //处理登录请求返回的结果
    //获取命令中的信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //监听命令的执行过程
    //跳过第一次
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            //正在执行
            //显示蒙版
        } else {
            //执行完成
            //隐藏蒙版
            NSLog(@"执行完成");
        }
    }];
}
@end
