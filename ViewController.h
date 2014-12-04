//
//  ViewController.h
//  Fickle Simple
//
//  Created by Guohao Jovian Ang on 16/10/14.
//  Copyright (c) 2014 Guohao Jovian Ang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "CustomCell.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *privacy;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton * post;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (nonatomic, strong) NSMutableArray* chat;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy,nonatomic) NSMutableArray * chat1;
@property (copy,nonatomic) NSMutableArray * chat2;


@property (strong, nonatomic) IBOutlet UIButton *resultsPage;
@property (strong, nonatomic) IBOutlet UIButton *postPage;

@property (strong, nonatomic) IBOutlet UITableView *resultsTableView;


@property (nonatomic, strong) Firebase* firebase;

@end

