//
//  UIButton+KNCountdown.h
//  KNAdministrator
//
//  Created by HuangLibo on 2017/10/12.
//  Copyright © 2017年 KNRT. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 倒计时 Button
 */
@interface UIButton (KNCountdown)

- (void)kn_startWithSeconds:(NSInteger)seconds
             countdownTitle:(NSString *)countdownTitle
        countdownTitleColor:(UIColor *)countdownTitleColor
                 endedTitle:(NSString *)endedTitle
            endedTitleColor:(UIColor *)endedTitleColor
                 completion:(void (^)(BOOL countdownEnded))completion;

@end
