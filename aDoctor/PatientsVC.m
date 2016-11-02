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
@property NSMutableArray *patientsArray;
@property NSMutableArray *patientsInsuranceArray;
@property NSMutableArray *patientsAgeArray;
@property NSMutableArray *patientsGenderArray;

@end

@implementation PatientsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Get patients
    self.patientsArray = [NSMutableArray new];
    self.patientsAgeArray = [NSMutableArray new];
    self.patientsInsuranceArray = [NSMutableArray new];
    self.patientsGenderArray = [NSMutableArray new];
    
    [self getPatientsDate];

}


-(void)getPatientsDate{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://adoctor.herokuapp.com/api/user"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", jsonArray);
        
        for (NSDictionary *diction in jsonArray) {
        
            NSString *firstName = [diction objectForKey:@"firstName"];
            NSString *lastName = [diction objectForKey:@"lastName"];
            NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            NSString *gender = [diction objectForKey:@"gender"];
            NSString *insurance = [diction objectForKey:@"_insurancePlanID"];
            NSString *dob = [diction objectForKey:@"birthdate"];
            
            [self.patientsArray addObject:name];
            [self.patientsGenderArray addObject:gender];
            [self.patientsInsuranceArray addObject:insurance];
            [self.patientsAgeArray addObject:dob];
            
            NSLog(@"%@",diction);
            [self.tableView reloadData];
        }

    }] resume];
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PatientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell" forIndexPath:indexPath];
    //cell.patientImage.image = [self.patients
    cell.profileName.text = [self.patientsArray objectAtIndex:indexPath.row];
    cell.profileDetails.text = [NSString stringWithFormat:@"%@ | %@ | %@", [self.patientsGenderArray objectAtIndex:indexPath.row], [self.patientsAgeArray objectAtIndex:indexPath.row], [self.patientsInsuranceArray objectAtIndex:indexPath.row]];
    //[self.tableView reloadData];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.patientsArray.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PatientProfile"])
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
