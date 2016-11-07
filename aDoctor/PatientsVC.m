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
@property NSString *age;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSInteger currentMonth;
@property (nonatomic) NSInteger currentDate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PatientsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    
    //Get patients
    self.patientsArray = [NSMutableArray new];
    self.patientsAgeArray = [NSMutableArray new];
    self.patientsInsuranceArray = [NSMutableArray new];
    self.patientsGenderArray = [NSMutableArray new];
    
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    NSArray<NSString *> *components = [currentDateString componentsSeparatedByString:@"-"];
    self.currentYear = components.firstObject.integerValue;
    self.currentMonth = components[1].integerValue;
    self.currentDate = components[2].integerValue;
    
    
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
            
            NSString *gender = [NSString new];
            if ([[diction objectForKey:@"gender"]  isEqual: @"1"]) {
                gender = @"Female";
            }else{
                gender = @"Male";
            }
            
            //Calculating age from DOB
            [self calculateAge:[diction objectForKey:@"birthdate"]];
            NSString *age = [NSString stringWithFormat:@"%@ yrs",self.age];

            
            NSString *insurance = [diction objectForKey:@"_insurancePlanID"];
            
            [self.patientsArray addObject:name];
            [self.patientsGenderArray addObject:gender];
            [self.patientsInsuranceArray addObject:insurance];
            [self.patientsAgeArray addObject:age];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });

            NSLog(@"%@",diction);
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
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath isEqual:((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject])]){
        //end of loading
        [self.activityIndicator stopAnimating];
        
    }
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

- (void)calculateAge:(NSString *)dateOfBirth {
    
    NSArray<NSString *> *dateOfBirthComponents = [dateOfBirth componentsSeparatedByString:@"-"];
    
    NSInteger birthYear = dateOfBirthComponents.firstObject.integerValue;
    NSInteger birthMonth = dateOfBirthComponents[1].integerValue;
    
    NSInteger finalAge;
    NSInteger preliminaryAge = self.currentYear - birthYear;
    
    NSInteger monthDifference = self.currentMonth - birthMonth;
    if (monthDifference > 0) {
        finalAge = preliminaryAge;
    } else if (monthDifference == 0) {
        NSInteger birthDate = dateOfBirthComponents[2].integerValue;
        NSInteger dateDifference = self.currentDate - birthDate;
        
        if (dateDifference > 0) {
            finalAge = preliminaryAge;
        } else if (dateDifference == 0) {
            finalAge = preliminaryAge;
        } else {
            finalAge = preliminaryAge - 1;
        }
    } else {
        finalAge = preliminaryAge - 1;
    }
    
    self.age = [NSString stringWithFormat:@"%li", (long)finalAge];
    
    
    

}



@end
