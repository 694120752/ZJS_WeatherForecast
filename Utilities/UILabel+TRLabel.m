//
//  UILabel+TRLabel.m
//  TRWeatherForcast
//
//  Created by tarena on 15/11/18.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "UILabel+TRLabel.h"

@implementation UILabel (TRLabel)

+ (UILabel *)labelWithFrame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    
    return label;
}











@end
