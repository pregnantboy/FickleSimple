//
//  UITableViewCell+ResultsCustomCell.h
//  Fickle Simple
//
//  Created by Guohao Jovian Ang on 24/11/14.
//  Copyright (c) 2014 Guohao Jovian Ang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"

@interface ResultsCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *resquestion;
@property (nonatomic, retain) IBOutlet DLPieChart *resPieChartView;
@end
