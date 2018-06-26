//
//  ViewController.m
//  ReactiveCoCoDemo
//
//  Created by linjianguo on 2018/6/23.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "RedView.h"

@interface ViewController ()

@property (nonatomic,strong) id<RACSubscriber> subscriber;
@property (weak, nonatomic) IBOutlet RedView *redV;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController
- (IBAction)btnactionNew:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self first];
   // [self second];
   // [self three];
    
    //订阅信号
//    [_redV.btnClickSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [self four];
//
//    [self five];
//
//    [self six];
    
    //[self seven];
//    [_redV rac_observeKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//        //
//
//    }];
//    [[_redV rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    //代替点击事件
//    [[_btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"按钮被点击了");
//    }];
    //通知
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"小明");
//    }];
    
    //[self newMethod];
    
    
    
}
- (void)newMethod
{
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //请求数据
        NSLog(@"请求数据热销模块");
        [subscriber sendNext:@"热销模块数据"];
        return nil;
    }];
    
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //请求数据
        NSLog(@"请求最新模块");
        [subscriber sendNext:@"请求最新模块"];
        return nil;
    }];
    
    //当一个界面有多个请求的时候，需要保证全部请求完成，才搭建界面
    //当数组中的所有信号都发送数据的时候，才会执行Selector
    //方法的参数：必须跟数组的信号----对应
    //方法的参数；就是每个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal,newSignal]];
}
- (void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData
{
    //拿到请求的数据
    NSLog(@"更新UI");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _redV.frame = CGRectMake(0, 0, 100, 100);
}
- (void)seven
{
    [[_redV rac_signalForSelector:@selector(btnaction:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"控制器知道按钮被点击");
    }];
}
- (void)six
{
    NSDictionary *dict =@{@"1":@"小明"};
    
    NSArray *arr1 = [[dict.rac_sequence map:^id _Nullable(NSDictionary *value) {
        
        return nil;
    }] array];
    NSLog(@"arr:%@",arr1);
    
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple  * x) {
//        NSString *key = x[0];
//        NSString *value = x[1];
//        NSLog(@"%@---%@",key,value);
        //用来解析元组
        //宏里面的参数，传需要解析出来的变量名
        // = 右边，放需要解析的元组
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"%@---%@",key,value);
    }];
}
- (void)five
{
    NSArray *arr = @[@"123",@"234",@"456"];
    //把数组转化成集合
    RACSequence *squence = arr.rac_sequence;
    //集合转化为信号
    RACSignal *signal = squence.signal;
    //订阅集合信号，内部会自动便利所有的元素发出来
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)four
{
    //元祖
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"1",@"2",@3]];
    NSString *firstStr = tuple[0];
    NSLog(@"%@",firstStr);
}
- (void)three
{
    //既可以订阅信号也可以发送数据
    
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据:%@",x);
    }];
    
    //3.发送信号
    [subject sendNext:@1];
}
- (void)second
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //保存下
        self->_subscriber = subscriber;
        
        //发送信号
        [subscriber sendNext:@111];
        
        return [RACDisposable disposableWithBlock:^{
            //只要信号取消订阅就会来这里
            //清空资源
            NSLog(@"信号被取消订阅了");
        }];
        
    }];
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //默认一个信号发送数据完毕，就会主动取消订阅.
    //只要订阅者在，就不会自动取消信号订阅.
    //取消订阅信号
    [disposable dispose];
}
- (void)first
{
    //1.创建信号(冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"信号被订阅了");
        //3.发送数据
        [subscriber sendNext:@"1"];
        return nil;
    }];
    //2.订阅信号(热信号)
    [signal subscribeNext:^(id  _Nullable x) {
        //nextBlock调用:只要订阅者发送数据就会被调用
        
        //x:发送信号的内容
        NSLog(@"%@",x);
    }];
    
}





@end
