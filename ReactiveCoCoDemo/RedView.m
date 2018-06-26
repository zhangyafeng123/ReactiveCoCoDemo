//
//  RedView.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/25.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "RedView.h"

@implementation RedView
//get方法重写
//- (RACSubject *)btnClickSignal
//{
//    if (_btnClickSignal == nil) {
//        _btnClickSignal = [RACSubject subject];
//    }
//    return _btnClickSignal;
//}
//按钮点击事件
- (IBAction)btnaction:(id)sender
{
    NSLog(@"按钮点击了");
    
    // [self.btnClickSignal sendNext:@"小明"];
    
    
    
    
}



@end
