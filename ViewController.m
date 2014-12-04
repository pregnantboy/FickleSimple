//
//  ViewController.m
//  Fickle Simple
//
//  Created by Guohao Jovian Ang on 16/10/14.
//  Copyright (c) 2014 Guohao Jovian Ang. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "ResultsCustomCell.h"
#import "Firebase/Firebase.h"
#define fireurl @"https://fiery-fire-7376.firebaseio.com/messagelog"
#define maxLog 30

@interface ViewController ()


@end


@implementation ViewController
@synthesize textField,privacy,username,tableView,chat1,chat2,resultsTableView;

//NSMutableArray *chat1=nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    resultsTableView.delegate = self;
    resultsTableView.dataSource = self;
    
    
    Firebase *fb = [[Firebase alloc] initWithUrl:fireurl];
    //reloads table when new msges show up
    //if new message not printed, internet connection is down
    //[fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
     //   [self.tableView reloadData];
    //}];
    [fb observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        //NSLog(@"new message,%@",snapshot.value);
        //NSLog(@"chat1 %@",chat1);
        [chat1 insertObject:snapshot.value atIndex:0];
        //NSLog(@"chat1-2 %@",chat1);
        [self.tableView reloadData];
        [self.resultsTableView reloadData];
    }];
    
    [fb observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        // Reload the table view so that the intial messages show up
        //NSInteger logcounter = [snapshot.value count];
        //NSLog(@"log counter %ld",(long)logcounter);
        chat1=[[NSMutableArray alloc]init];
        chat2=[[NSMutableArray alloc]init];
        
        NSMutableDictionary *dict = nil;
        dict = snapshot.value;
        //NSLog(@"dict %@",dict);
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        if (dict != [NSNull null]){
            temp = [dict allValues];
            NSSortDescriptor *timesorter = [[NSSortDescriptor alloc]initWithKey:@"time"ascending:NO];
            NSMutableArray *sorter = @[timesorter];
            NSMutableArray *sortedArray = [temp sortedArrayUsingDescriptors:sorter];
            //NSLog(@"sortedArray %@",sortedArray);
            int counter = [sortedArray count];
            //NSLog(@"counter,%d",counter);
            for (int i = 0; i<counter;++i){
                //NSLog(@"count test%@",sortedArray[i]);
                [chat1 addObject:sortedArray[i]];
            }
           // NSLog(@"chat1,%@",chat1);
            //NSLog(@"start");
            for (int i = 0; i<counter;++i){
                if ([chat1[i][@"name"] isEqualToString:username.text]){
                    
                    [chat2 addObject:chat1[i]];
                }
            }
            NSLog(@"chat2,%@",chat2);
            
        }
        
        
        //NSLog(@"end");
        [self.tableView reloadData];
        [self.resultsTableView reloadData];
        

    }];
    
    
    //test array
    //self.chat1 = @[@"one",@"two",@"three"];
    
}

- (IBAction)buttonPressed:(id)sender {
    [textField resignFirstResponder];
    Firebase *fb = [[Firebase alloc] initWithUrl:fireurl];
    NSString *name = username.text;
    if(privacy.selectedSegmentIndex == 1){
        name = @"Anonymous";
    }
    NSDate *now = [NSDate date];
    NSNumber *nowConverted = [NSNumber numberWithDouble:[now timeIntervalSinceReferenceDate]];
    [[fb childByAutoId] setValue:@{@"name":name,@"text": textField.text,@"time":[NSNumber numberWithInt:[nowConverted intValue]]}];
    [textField setText:@""];
}
- (IBAction)returnKeyButton:(UITextField*)aTextField{
    [textField resignFirstResponder];
    Firebase *fb = [[Firebase alloc] initWithUrl:fireurl];
    NSString *name = username.text;
    if(privacy.selectedSegmentIndex == 1){
        name = @"Anonymous";
    }
    NSDate *now = [NSDate date];
    NSNumber *nowConverted = [NSNumber numberWithDouble:[now timeIntervalSinceReferenceDate]];
    [[fb childByAutoId] setValue:@{@"name":name,@"text": textField.text,@"time":[NSNumber numberWithInt:[nowConverted intValue]]}];
    [textField setText:@""];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    // This is the number of chat messages.
    //NSInteger counter= [chat1 count];
    //NSLog(@"chat count %ld",(long)counter);
    if (tableView!=resultsTableView){
        return (long)[chat1 count];
    }
    else {
        NSLog(@"chat 2 count %d",[self.chat2 count]);
        return (long)[chat2 count];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)index
{
    static NSString *CellIdentifier = @"Cell";
    
    if (tableView!= resultsTableView){
        CustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil) {
            cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    
        NSDictionary *msg = chat1[index.row];
        cell.cellquestion.text = msg[@"text"];
        cell.cellusername.text = msg[@"name"];
        cell.celloption1.text = @"Yes";
        cell.celloption2.text = @"No";
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSNumber *number1 = [NSNumber numberWithInt:5];
        NSNumber *number2 = [NSNumber numberWithInt:3];
        [dataArray addObject:number1];
        [dataArray addObject:number2];
    
        [cell.pieChartView renderInLayer:cell.pieChartView dataArray:dataArray];
        return cell;
    }
    
    else{
        ResultsCustomCell *cell = [self.resultsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil) {
            cell = [[ResultsCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        //NSLog(@"hello, %@",chat2);
        NSDictionary *msg =chat2[index.row];
        cell.resquestion.text = msg[@"text"];
        NSLog(@"question %@",cell.resquestion.text);
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSNumber *number1 = [NSNumber numberWithInt:5];
        NSNumber *number2 = [NSNumber numberWithInt:3];
        [dataArray addObject:number1];
        [dataArray addObject:number2];
        
        [cell.resPieChartView renderInLayer:cell.resPieChartView
                                  dataArray:dataArray];
        return cell;
    }
    
    
    //NSLog(@"%@",chat[index.row]);
    
}
/*
- (NSInteger)resultsTableView:(UITableView*)resultsTableView numberOfRowsInSection:(NSInteger)section2
{
    NSLog(@"hello");
    // This is the number of chat messages.
    //NSInteger counter= [chat1 count];
    //NSLog(@"chat count %ld",(long)counter);
    return (long)[chat2 count];
}

- (UITableViewCell*)resultsTableView:(UITableView*)resultsTableView cellForRowAtIndexPath:(NSIndexPath *)index2
{
    NSLog(@"hello");
    static NSString *CellIdentifier2 = @"Cell2";
    CustomCell *cell = [self.resultsTableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
    }
    
    NSDictionary *msg = chat2[index2.row];
    NSLog(@"hello");
    NSLog(@"%@",msg);
    
    cell.toplayer.alpha=0;
    cell.toplayer.userInteractionEnabled=FALSE;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSNumber *number1 = [NSNumber numberWithInt:5];
    NSNumber *number2 = [NSNumber numberWithInt:3];
    [dataArray addObject:number1];
    [dataArray addObject:number2];
    
    [cell.pieChartView renderInLayer:cell.pieChartView dataArray:dataArray];
    
    
    //NSLog(@"%@",chat[index.row]);
    return cell;
}



*/



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
