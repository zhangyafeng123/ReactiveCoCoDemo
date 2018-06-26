//
//  sevenViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "sevenViewController.h"
#import "Header.h"
@interface sevenViewController ()

@end

@implementation sevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //组合
    [self second];
    [self three];
}
- (void)three
{
    
}
- (void)second
{
    //创建信号A
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送请求
        NSLog(@"发送顶部请求");
        [subscriber sendNext:@"发送上部分数据"];
        //发送完成
        [subscriber sendCompleted];
        return nil;
    }];
    //创建信号B
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送请求
        NSLog(@"发送底部请求");
        [subscriber sendNext:@"发送下部分数据"];
        
        
        return nil;
    }];
    //忽略到第一个信号的所有值 then
    RACSignal *s = [signalA then:^RACSignal * _Nonnull{
        //返回的信号就是要组合的信号
        return signalB;
    }];
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}
- (void)first
{
    //创建信号A
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送请求
        NSLog(@"发送顶部请求");
        [subscriber sendNext:@"发送上部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];
    //创建信号B
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送请求
        NSLog(@"发送底部请求");
        [subscriber sendNext:@"发送下部分数据"];
        
        
        return nil;
    }];
    //按顺序去连接
    //注意:concat第一个信号必须要调用 [subscriber sendCompleted];
    //创建组合信号
    RACSignal *rac = [signal concat:signal1];
    [rac subscribeNext:^(id  _Nullable x) {
        //既能拿到A的值，也能拿到B
        NSLog(@"%@",x);
    }];
}



@end
