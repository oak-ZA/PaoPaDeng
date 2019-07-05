//
//  MoreLeaveView.h
//  activityentrance
//
//  Created by 张奥 on 2019/6/24.
//  Copyright © 2019年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreLeaveView : UIView
//倒计时时间
@property (nonatomic,assign) NSInteger currentTimer;
//倒计时结束
@property (nonatomic,copy) void(^TimeStop)(void);
-(void)stop;
@end
