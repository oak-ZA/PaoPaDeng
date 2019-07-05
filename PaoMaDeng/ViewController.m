//
//  ViewController.m
//  PaoMaDeng
//
//  Created by 张奥 on 2019/7/5.
//  Copyright © 2019年 张奥. All rights reserved.
//

#import "ViewController.h"
#import "MoreLeaveView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MoreLeaveView *leaveView = [[MoreLeaveView alloc] initWithFrame:CGRectMake(0, 150, 204.f, 20.f)];
    leaveView.backgroundColor = [UIColor blueColor];
    leaveView.currentTimer = 60;
    [self.view addSubview:leaveView];
    leaveView.TimeStop = ^{
        //倒计时结束离开房间
        
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
