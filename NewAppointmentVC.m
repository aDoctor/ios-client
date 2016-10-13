//
//  NewAppointmentVC.m
//  aDoctor
//
//  Created by David Iskander on 10/1/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "NewAppointmentVC.h"
#import "NewAppointmentReminderCell.h"

@interface NewAppointmentVC ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property NSArray *patient;
@property NSArray *scheduledFollowUp;
@property (weak, nonatomic) IBOutlet UIButton *goButton;


@end

@implementation NewAppointmentVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Data
    self.patient = @[@"Dave William", @"John Jone's", @"Jose Diaz"];
    self.scheduledFollowUp = @[@"Oct 3rd, 2016", @"Oct 4th, 2016", @"Oct 4th, 2016"];
    
    //Go button style
    self.goButton.layer.cornerRadius = 5;
    self.goButton.clipsToBounds = YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewAppointmentReminderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.reminderName.text = [self.patient objectAtIndex:indexPath.row];
    cell.reminderDate.text = [self.scheduledFollowUp objectAtIndex:indexPath.row];
    [cell.reminderMail addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.patient.count;
}


-(void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"You are about to send a reminder to patient" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Do stuff; emailing function
        }];
    [alert addAction:sendAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (IBAction)onGoButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"AddAppointment" sender:nil];
}


@end
