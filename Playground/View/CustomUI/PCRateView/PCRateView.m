//
//  PCRateView.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCRateView.h"

@interface PCRateView() {
    NSMutableArray *maryButStar;
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
    maryButStar = [[NSMutableArray alloc] init];
    
    [maryButStar addObject:self.mButStar1];
    [maryButStar addObject:self.mButStar2];
    [maryButStar addObject:self.mButStar3];
    [maryButStar addObject:self.mButStar4];
    [maryButStar addObject:self.mButStar5];
    
    for (UIButton *button in maryButStar) {
        [button addTarget:self action:@selector(onButStar:) forControlEvents:UIControlEventTouchUpInside];
    }
}

+ (id)getView {
    return [super getView:@"PCRateView"];
}

/**
 init stars according to the rate
 @param rate 0~100
 */
- (void)setRate:(NSInteger)rate {
    mnStar = round(rate / 20.0) - 1;
    [self onButStar:nil];
}

- (void)onButStar:(id)sender {

    if (sender) {
        // this is setting star manually
        NSInteger nTag = ((UIButton *)sender).tag;
        mnStar = (int)nTag;
    }
    
    // remove all star
    for (UIButton *button in maryButStar) {
        [button setImage:[UIImage imageNamed:@"rate_star_disable"] forState:UIControlStateNormal];
    }
    
    // set star
    for (int i = 0; i <= mnStar; i++) {
        UIButton *button = maryButStar[i];
        [button setImage:[UIImage imageNamed:@"rate_star"] forState:UIControlStateNormal];
    }
}


@end
