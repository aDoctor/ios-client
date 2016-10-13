//
//  AddNewAppointmentVC.m
//  aDoctor
//
//  Created by David Iskander on 10/11/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "AddNewAppointmentVC.h"
#import "FSCalendar.h"
#import "FSCalendarAnimator.h"
#import "FSCalendarDynamicHeader.h"
#import "UIView+FSExtension.h"
#import "FSCalendarAppearance.h"


@interface AddNewAppointmentVC () <FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *availableAppointments;

@end

@implementation AddNewAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.availableAppointments = @[@"9:00 am", @"10:00am", @"11:15am", @"2:00pm", @"2:15pm"];
    // Do any additional setup after loading the view.
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.availableAppointments objectAtIndex:indexPath.row];
      return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.availableAppointments.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Available Times For Appointments";
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *date = cell.textLabel.text;
    
    //Just for now .. TEST .. HARDCODING .. SHOULDN'T DO
    [self showAlert:@"David" :date :@"Feb 22nd, 2017"];
    
}


-(void)showAlert:(NSString *)name :(NSString *)time :(NSString *)date
{
    NSString *alertMessage = [NSString stringWithFormat:@"Confirming an appointment for %@ at %@ at %@", name, time, date];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Setting appointment" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Do stuff; emailing function
    }];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
