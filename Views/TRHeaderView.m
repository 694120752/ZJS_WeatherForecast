//
//  TRHeaderView.m
//  WeatherForecast
//
//  Created by 张精申 on 16/2/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHeaderView.h"
#import "UILabel+TRLabel.h"
//label左右边距
static const CGFloat inset = 20;
//label高
static const CGFloat labelHeight = 40;
//当前温度label高
static const CGFloat tempLabelHeight = 110;

@implementation TRHeaderView
//添加6个控件
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
        CGRect buttonFrame = CGRectMake(0, inset,labelHeight, labelHeight);
        self.menuButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [self.menuButton setImage:[UIImage imageNamed:@"IconHome"] forState:UIControlStateNormal];
        [self addSubview:self.menuButton];
        
        //城市Label
        CGRect cityLabelRect = CGRectMake(labelHeight, inset, SCREEN_WIDTH, labelHeight);
        self.cityLabel = [UILabel labelWithFrame:cityLabelRect];
        self.cityLabel.text = @"Loading...";
        self.cityLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.cityLabel];
        
        //最低最高Label
        CGRect hiloLabelRect = CGRectMake(inset, SCREEN_HEIGHT-labelHeight, SCREEN_WIDTH-2*inset, labelHeight);
        self.hiloLabel = [UILabel labelWithFrame:hiloLabelRect];
        self.hiloLabel.text = @"0˚ / 10˚";
        //self.hiloLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.hiloLabel];
        
        //当前温度
        CGRect tempLabelRect = CGRectMake(inset, SCREEN_HEIGHT-labelHeight-tempLabelHeight, frame.size.width-2*inset, tempLabelHeight);
        self.temperatureLabel = [UILabel labelWithFrame:tempLabelRect];
        self.temperatureLabel.text = @"10˚";
        self.temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:80];
        [self addSubview:self.temperatureLabel];
        
        //天气iconView
        CGRect iconViewRect = CGRectMake(inset, tempLabelRect.origin.y-labelHeight, labelHeight, labelHeight);
        self.iconView = [[UIImageView alloc] initWithFrame:iconViewRect];
        self.iconView.image = [UIImage imageNamed:@"placeholder.png"];
        [self addSubview:self.iconView];
        
        //天气的描述
        CGRect conditionRect = CGRectMake(inset+labelHeight, iconViewRect.origin.y, SCREEN_WIDTH-2*inset-labelHeight, labelHeight);
        self.conditionsLabel = [UILabel labelWithFrame:conditionRect];
        self.conditionsLabel.text = @"Sunny";
        //self.conditionsLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:self.conditionsLabel];
    
    
    
    }
    return self;
}






@end
