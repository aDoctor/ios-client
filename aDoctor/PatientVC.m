//
//  PatientVC.m
//  aDoctor
//
//  Created by David Iskander on 9/27/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "PatientVC.h"

@interface PatientVC ()<UITableViewDataSource,UITableViewDelegate>
@property NSArray *dateOfVisits;
@property NSArray *typeOfVisits;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderAndAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuranceLabel;
@end

@implementation PatientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.name;
    self.genderAndAgeLabel.text = [NSString stringWithFormat:@"%@ | %@", self.gender, self.age];
    self.insuranceLabel.text = self.insurance;
    
    
    self.dateOfVisits = @[@"October 4th, 2016 | 12:00pm", @"September 4th, 2016 | 3:00pm", @"August 4th, 2016 | 12:00pm", @"July 4th, 2016 | 12:00pm", @"June 4th, 2016 | 11:00am", @"March 4th, 2016 | 2:00pm", @"February 4th, 2016 | 1:00pm"];
    self.typeOfVisits = @[@"follow up", @"follow up" ,@"follow up" ,@"Visit" ,@"follow up" ,@"Visit", @"Visit"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.dateOfVisits objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.typeOfVisits objectAtIndex:indexPath.row];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateOfVisits.count;
}


@end
