//
//  CustomCell.h
//  Fickle Simple
//
//  Created by Guohao Jovian Ang on 6/11/14.
//  Copyright (c) 2014 Guohao Jovian Ang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cellquestion;
@property (strong, nonatomic) IBOutlet UILabel *celloption1;
@property (strong, nonatomic) IBOutlet UILabel *celloption2;
@property (strong, nonatomic) IBOutlet UILabel *cellusername;
@property (strong, nonatomic) IBOutlet UIView *toplayer;
@property (strong, nonatomic) IBOutlet UIImageView *leftarrow;
@property (strong, nonatomic) IBOutlet UIImageView *rightarrow;
@property (nonatomic, retain) IBOutlet DLPieChart *pieChartView; 

@end
