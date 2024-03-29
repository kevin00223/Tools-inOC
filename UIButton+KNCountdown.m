//
//  UIButton+KNCountdown.m
//  KNAdministrator
//
//  Created by HuangLibo on 2017/10/12.
//  Copyright © 2017年 KNRT. All rights reserved.
//

#import "UIButton+KNCountdown.h"

@implementation UIButton (KNCountdown)

- (void)kn_startWithSeconds:(NSInteger)seconds
             countdownTitle:(NSString *)countdownTitle
        countdownTitleColor:(UIColor *)countdownTitleColor
                 endedTitle:(NSString *)endedTitle
            endedTitleColor:(UIColor *)endedTitleColor
                 completion:(void (^)(BOOL countdownEnded))completion {
    
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = seconds;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:endedTitle forState:UIControlStateNormal];
                [weakSelf setTitleColor:endedTitleColor forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)seconds + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:[NSString stringWithFormat:@"%@%@",timeStr,countdownTitle] forState:UIControlStateNormal];
                [weakSelf setTitleColor:countdownTitleColor forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
                completion(YES);
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

@end
