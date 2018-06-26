//
//  sixViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "sixViewController.h"
#import "Header.h"
@interface sixViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation sixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self first];
    
    [self second];
}
- (void)second
{
    /**
     忽略对应的值，忽略所有值。
     */
    RACSubject *subject = [RACSubject subject];
    [[subject ignore:@"111"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@---",x);
    }];
    [subject sendNext:@"111"];
    
}
- (void)first
{
    //过滤,满足这个条件，才能获取到内容...
    [[_textF.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return  value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}



@end
