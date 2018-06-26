//
//  RequestViewModel.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/26.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "RequestViewModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation RequestViewModel

- (instancetype)init
{
    if ([super init]) {
        [self setup];
    }
    return self;
}
/**
 或者使用懒加载
 */
- (void)setup
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        //执行命令
        
        //创建信号
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            //发送请求
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                /**
                 转化为模型数组
                 */
                NSArray *arr = responseObject[@"books"];
                NSArray *modelArray= [[arr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                    return [NSObject new];
                }] array];
                //请求成功
                [subscriber sendNext:modelArray];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
            return nil;
        }];
        
        
        return signal;
        
    }];
    
}
@end
