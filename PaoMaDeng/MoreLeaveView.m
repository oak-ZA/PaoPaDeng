//
//  MoreLeaveView.m
//  activityentrance
//
//  Created by 张奥 on 2019/6/24.
//  Copyright © 2019年 Leon. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
#import "MoreLeaveView.h"
@interface MoreLeaveView()
//定时器
@property (nonatomic,strong) NSTimer *timer;
//富文本
@property (nonatomic,strong) NSMutableAttributedString *attriString;
//滚动背景
@property (nonatomic,strong) UIView *bgView;
//滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;
//主label
@property (nonatomic,strong) UILabel *mainLabel;
//副label
@property (nonatomic,strong) UILabel *label;
//间隙
@property (nonatomic,assign) NSInteger space;
//宽度
@property (nonatomic,assign) CGFloat width;


@end
@implementation MoreLeaveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 173.f, 20.f)];
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}
-(UILabel*)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:12.f];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.backgroundColor = [UIColor clearColor];
        
    }
    return _label;
}

-(UILabel*)mainLabel{
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] init];
        _mainLabel.font = [UIFont systemFontOfSize:12.f];
        _mainLabel.textColor = [UIColor whiteColor];
        _mainLabel.textAlignment = NSTextAlignmentLeft;
        _mainLabel.backgroundColor = [UIColor clearColor];
        
    }
    return _mainLabel;
}
-(NSMutableAttributedString*)attriString{
    if (!_attriString) {
        _attriString = [[NSMutableAttributedString alloc] init];
    }
    return _attriString;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.space = 10;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //警告图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.f, (20.f-11.f)/2.f, 11.f, 11.f)];
    imageView.image = [UIImage imageNamed:@"notice_white"];
    [self addSubview:imageView];
    //背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(22.f, 0, 183.f, 20.f)];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    [bgView addSubview:self.scrollView];
    [self.scrollView addSubview:self.mainLabel];
    [self.scrollView addSubview:self.label];
    [self timerStrWithTotalTime:self.currentTimer];
    self.mainLabel.frame = CGRectMake(0, 0, self.width, 20.f);
    self.label.frame = CGRectMake(CGRectGetMaxX(self.mainLabel.frame)+self.space, 0, self.width, 20.f);
    //定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self doAnimation];
}

-(void)doAnimation{
    self.scrollView.contentOffset = CGPointZero;
    NSTimeInterval duration = (self.width+self.space) / 15;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentOffset = CGPointMake(self.width + self.space, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self performSelector:@selector(doAnimation) withObject:nil];
        }
    }];
}

-(void)countDown{
    self.currentTimer --;
    if (self.currentTimer <= 0) {
        [self stop];
        if (self.TimeStop) {
            self.TimeStop();
        }
    }
    [self timerStrWithTotalTime:self.currentTimer];
}
-(void)timerStrWithTotalTime:(NSInteger)totalTime{
    long min = self.currentTimer / 60;
    long sec = self.currentTimer % 60;
    NSString *str = [NSString stringWithFormat:@"房主已离开，房间将在%0.2ld:%0.2ld后关闭",min,sec];
    self.width = [self getLabelWidthWithString:str];
    if (self.width <= 173.f) {
        self.width = 173.f;
    }
    self.scrollView.contentSize = CGSizeMake(self.width+173.f+self.space, 0);
    [self.attriString replaceCharactersInRange:NSMakeRange(0, self.attriString.length) withString:str];
    [self.attriString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12.f]} range:NSMakeRange(0, str.length)];
    [self.attriString addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0XFFDF4A)} range:NSMakeRange(str.length - 8, 5)];
    self.mainLabel.attributedText = self.attriString;
    self.label.attributedText = self.attriString;
}
-(CGFloat)getLabelWidthWithString:(NSString*)text{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil];
    return rect.size.width+5;
}
-(void)stop{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)dealloc{
    [self stop];
}
@end
