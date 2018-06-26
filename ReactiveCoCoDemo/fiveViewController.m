//
//  fiveViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "fiveViewController.h"
#import "Header.h"
#import <ReactiveObjC/RACReturnSignal.h>
@interface fiveViewController ()

@end

@implementation fiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
/**
 推荐使用....
 */
- (void)second
{
    //相当于进一步的改装数据类型....
    RACSubject *subject = [RACSubject subject];
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
        
        return [NSString stringWithFormat:@"xiaming----%@",value];
        
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject sendNext:@"gege"];
}


- (void)first
{
    RACSubject *subject = [RACSubject subject];
    //其实就是内部包装了一层
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        //value:就是源信号发送内容
        value = [NSString stringWithFormat:@"小何---%@",value];
        //返回信号用来包装成修改内容值
        return [RACReturnSignal return:value];
    }];
    
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"小明"];
}



@end
