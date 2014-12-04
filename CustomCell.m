//
//  CustomCell.m
//  Fickle Simple
//
//  Created by Guohao Jovian Ang on 6/11/14.
//  Copyright (c) 2014 Guohao Jovian Ang. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize toplayer,cellquestion,cellusername,celloption1,celloption2,leftarrow,rightarrow,pieChartView;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    toplayer.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [toplayer addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [toplayer addGestureRecognizer:swipeLeft];
    pieChartView.alpha=0;

}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    CGRect frame1 = leftarrow.frame;
    CGRect frame2 = rightarrow.frame;
    
    // I don't know how far you want to move the grid view.
    // This moves it off screen.
    // Adjust this to move it the appropriate amount for your desired UI
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        frame1.origin.x -= 1.5*leftarrow.bounds.size.width;
        frame2.origin.x += 1.5*rightarrow.bounds.size.width;
        [UIImageView animateWithDuration:0.15
                         animations:^{
                             leftarrow.alpha=0;
                         }];
        [UIImageView animateWithDuration:0.5
                         animations:^{
                             leftarrow.frame = frame1;
                             rightarrow.frame = frame2;
                             pieChartView.alpha=1;
                             toplayer.alpha=0;
                         }];
        toplayer.userInteractionEnabled = NO;
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        frame1.origin.x -= 1.5*leftarrow.bounds.size.width;
        frame2.origin.x += 1.5*rightarrow.bounds.size.width;
        [UIImageView animateWithDuration:0.15
                         animations:^{
                             rightarrow.alpha=0;
                         }];
        [UIImageView animateWithDuration:0.5
                         animations:^{
                             leftarrow.frame = frame1;
                             rightarrow.frame = frame2;
                             pieChartView.alpha=1;
                             toplayer.alpha=0;
                         }];
        toplayer.userInteractionEnabled = NO;
    }
    else
        NSLog(@"Unrecognized swipe direction");
    
    // Now animate the changing of the frame
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    [toplayer addSubview:leftarrow];
    [toplayer addSubview:rightarrow];
    [leftarrow addSubview:celloption1];
    [rightarrow addSubview:celloption2];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    rightarrow.alpha=1;
    leftarrow.alpha=1;
    pieChartView.alpha=0;
    toplayer.userInteractionEnabled = YES;
    toplayer.alpha=1;
    
    
}

@end
