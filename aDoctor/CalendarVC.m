//
//  CalendarVC.m
//  aDoctor
//
//  Created by David Iskander on 9/29/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "CalendarVC.h"
#import "FSCalendar.h"
#import "FSCalendarAnimator.h"
#import "FSCalendarDynamicHeader.h"
#import "UIView+FSExtension.h"
#import "FSCalendarAppearance.h"


@interface CalendarVC () <FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *patients;
@property NSArray *times;

@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.patients = @[@"David Alex", @"John Wood", @"Eli Luther", @"Mary King"];
    self.times = @[@"9:00am", @"9:30", @"11:00am", @"12:30"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.patients objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.times objectAtIndex:indexPath.row];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.patients.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Visits Scheduled for the selected Day";
}



@end
