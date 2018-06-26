//
//  firstViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "firstViewController.h"
#import "Header.h"
@interface firstViewController ()
@property (nonatomic,strong) RACSignal *signal;
@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决循环引用..........
    @weakify(self);
    //循环引用
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSLog(@"%@",self);
        return nil;
    }];
    _signal = signal;
    //包装元组
    RACTuple *tuple = RACTuplePack(@1,@2);
    NSLog(@"%@",tuple[0]);
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
