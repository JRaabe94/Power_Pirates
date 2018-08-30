//
//  PiratButtonStyle.m
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "PiratButtonStyle.h"

@implementation PiratButtonStyle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 115, 50);
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 8.0f;
    self.layer.backgroundColor = UIColor.blackColor.CGColor;
    
    self.titleLabel.font = [UIFont fontWithName:@"Chalkduster"  size:15];
    self.titleLabel.textColor = UIColor.whiteColor;
}

@end
