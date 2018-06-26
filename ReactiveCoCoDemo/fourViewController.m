//
//  fourViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "fourViewController.h"
#import "Header.h"
#import <ReactiveObjC/RACReturnSignal.h>
@interface fourViewController ()

@end

@implementation fourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSubject *subject = [RACSubject subject];
    //2.
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return^RACSignal*(id value,BOOL *stop){
            //block调用:只要源信号发送数据，就会调用block
            //block作用:处理源信号内容
            //value:源信号发送的内容
            //返回信号，不能传nil,返回空信号
            value = [NSString stringWithFormat:@"xmg:%@",value];
            
            return [RACReturnSignal return:value];
        };
    }];
    //3.订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        //当处理完信号发送数据的时候，就会调用这个block;
        NSLog(@"接收到绑定信号处理完的信号%@",x);
    }];
    //4.发送数据
    [subject sendNext:@"123"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
