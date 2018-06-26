//
//  RequestViewModel.h
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/26.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
@interface RequestViewModel : NSObject

/**
 请求命令
 */
@property (nonatomic,strong) RACCommand *requestCommand;

@end
