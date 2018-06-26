//
//  NewViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "NewViewController.h"
#import "Header.h"
@interface NewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //只要这个对象的属性一改变就会产生信号
    [RACObserve(self.view, frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    

}
- (void)Rac
{
    //    [_textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
    //        self->_label.text  = x;
    //    }];
    //用来给某个对象的某个属性绑定信号，只要产生信号内容，就会把内容给属性赋值...
    RAC(_label,text) = _textfield.rac_textSignal;
    [self Rac];
}


@end
