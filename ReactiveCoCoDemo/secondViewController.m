//
//  secondViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "secondViewController.h"
#import "Header.h"
@interface secondViewController ()

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建信号
    
    //不管订阅多少次，都之后订阅一次
    //RACMuticastConnection:必须要有信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      
        //发送请求
        NSLog(@"发送热门模块的请求");
        [subscriber sendNext:@"热门模块"];
        return nil;
    }];
    
    
    //2.把信号转换成连接类
    RACMulticastConnection *connection = [signal publish];
    //3.订阅连接类的信号(订阅多次)
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号1%@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号2%@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号3%@",x);
    }];
    //4.连接
    [connection connect];
    
}



@end
