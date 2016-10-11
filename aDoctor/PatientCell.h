//
//  PatientCell.h
//  aDoctor
//
//  Created by David Iskander on 10/10/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileDetails;

@end
