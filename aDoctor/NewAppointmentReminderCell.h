//
//  NewAppointmentReminderCell.h
//  aDoctor
//
//  Created by David Iskander on 10/3/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAppointmentReminderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *reminderImage;
@property (weak, nonatomic) IBOutlet UILabel *reminderName;
@property (weak, nonatomic) IBOutlet UILabel *reminderDate;
@property (weak, nonatomic) IBOutlet UIButton *reminderMail;

@end
