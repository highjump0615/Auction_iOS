//
//  PCRateView.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCRateView.h"

@interface PCRateView() {
    NSMutableArray *aryButStar;
    int mnStar;
}

@property (weak, nonatomic) IBOutlet UIButton *mButStar1;
@property (weak, nonatomic) IBOutlet UIButton *mButStar2;
@property (weak, nonatomic) IBOutlet UIButton *mButStar3;
@property (weak, nonatomic) IBOutlet UIButton *mButStar4;
@property (weak, nonatomic) IBOutlet UIButton *mButStar5;

@end

@implementation PCRateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init star buttons
    aryButStar = [[NSMutableArray alloc] init];
    
    [aryButStar addObject:self.mButStar1];
    [aryButStar addObject:self.mButStar2];
    [aryButStar addObject:self.mButStar3];
    [aryButStar addObject:self.mButStar4];
    [aryButStar addObject:self.mButStar5];
    
    for (UIButton *button in aryButStar) {
        [button addTarget:self action:@selector(onButStar:) forControlEvents:UIControlEventTouchUpInside];
    }
}

+ (id)getView {
    return [super getView:@"PCRateView"];
}

- (void)onButStar:(id)sender {
    NSInteger nTag = ((UIButton *)sender).tag;
    
    mnStar = (int)nTag;
    
    // remove all star
    for (UIButton *button in aryButStar) {
        [button setImage:[UIImage imageNamed:@"rate_star_disable"] forState:UIControlStateNormal];
    }
    
    // set star
    for (int i = 0; i <= mnStar; i++) {
        UIButton *button = aryButStar[i];
        [button setImage:[UIImage imageNamed:@"rate_star"] forState:UIControlStateNormal];
    }
}


@end
