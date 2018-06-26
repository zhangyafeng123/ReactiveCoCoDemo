//
//  nineViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/26.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "nineViewController.h"
#import "Header.h"
#import "RequestViewModel.h"
@interface nineViewController ()
/**
 请求视图模型
 */
@property (nonatomic,strong) RequestViewModel *requestVM;
@end

@implementation nineViewController
- (RequestViewModel *)requestVM
{
    if (_requestVM == nil) {
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}


@end
