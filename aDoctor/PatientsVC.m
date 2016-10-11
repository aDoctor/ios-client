//
//  PatientsVC.m
//  aDoctor
//
//  Created by David Iskander on 9/27/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "PatientsVC.h"
#import "PatientCell.h"
#import "PatientVC.h"

@interface PatientsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *patientsArray;
@property NSArray *patientsInsuranceArray;
@property NSArray *patientsAgeArray;
@property NSArray *patientsGenderArray;

@end

@implementation PatientsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.patientsArray = @[@"David Alex", @"John Wood", @"Eli Luther", @"Mary King", @"Chris Gato", @"Aaron John", @"Barbra wood"];
    self.patientsGenderArray = @[@"Male", @"Male",@"Female",@"Female",@"Male",@"Male",@"Female"];
    self.patientsInsuranceArray = @[@"Kaiser Permenente", @"Anthem Blue cross", @"Blue Shield", @"Medical", @"Medicare", @"Kaiser Permenente", @"Anthem Blue cross"];
    self.patientsAgeArray = @[@"30", @"35", @"40", @"28", @"51", @"39", @"19"];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PatientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //cell.patientImage.image = [self.patients
    cell.profileName.text = [self.patientsArray objectAtIndex:indexPath.row];
    cell.profileDetails.text = [NSString stringWithFormat:@"%@ | %@ | %@", [self.patientsGenderArray objectAtIndex:indexPath.row], [self.patientsAgeArray objectAtIndex:indexPath.row], [self.patientsInsuranceArray objectAtIndex:indexPath.row]];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.patientsArray.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"patient"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        PatientVC *dVC = segue.destinationViewController;
        
        dVC.name = [self.patientsArray objectAtIndex:indexPath.row];
        dVC.age = [self.patientsAgeArray objectAtIndex:indexPath.row];
        dVC.insurance = [self.patientsInsuranceArray objectAtIndex:indexPath.row];
        dVC.gender = [self.patientsGenderArray objectAtIndex:indexPath.row];
    }
}




@end
