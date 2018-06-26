//
//  threeViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "threeViewController.h"
#import "Header.h"
@interface threeViewController ()

@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self first];
    [self second];
}
- (void)second
{
    //RacCommand:处理事件
    //不能返回一个空的信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input:%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"发送命令产生的数据"];
            
            return nil;
        }];
    }];
    
    //订阅信号
    //executionSignals信号源.............信号中的信号
    //这种方式必须要在执行命令前订阅....
    [command.executionSignals subscribeNext:^(RACSignal *x) {
        NSLog(@"%@",x);
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    //switchToLatest获取最新发送的信号，只能用于信号中的信号(信号源)
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //2.执行命令
    [command execute:@2];
    
}
- (void)first
{
    //RacCommand:处理事件
    //不能返回一个空的信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input:%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"发送命令产生的数据"];
            //数据发送完成
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    RACSignal *signal = [command execute:@1];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //监听事件有没有执行完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            NSLog(@"当前正在执行");
        } else {
            NSLog(@"执行完成/没有执行");
        }
    }];
}


@end
