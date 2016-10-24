//
//  NewPatientVC.m
//  aDoctor
//
//  Created by David Iskander on 10/2/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "NewPatientVC.h"

@interface NewPatientVC ()<UIScrollViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate, NSURLConnectionDelegate, UIImagePickerControllerDelegate>
{
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *mrnTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSString *mrn;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property NSString *contactNumber;
@property BOOL isMale;
@property NSString *insurance;
@property NSString *dateOfBirth;
@property NSString *dateStr;


@end

@implementation NewPatientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mrnTextField.delegate = self;
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.contactNumberTextField.delegate = self;
    self.dobTextField.delegate = self;
    self.insuranceTextField.delegate = self;
    [self registerForKeyboardNotifications];
    
    //Profile Image view
    self.profileImage.clipsToBounds = YES;
    self.profileImage.layer.cornerRadius = 75;
    self.profileImage.layer.borderWidth = 3.0f;
    self.profileImage.layer.borderColor = [UIColor colorWithRed:90 green:200 blue:250 alpha:1.0].CGColor;
    
    //Date of Birth picker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dobTextField setInputView:datePicker];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.contactNumberTextField) {
        return [self updatePhoneFieldTextField:textField withRange:range replacementString:string];
    }
    return YES;
}




#pragma mark - Phone Number

- (BOOL)updatePhoneFieldTextField:(UITextField *)textField withRange:(NSRange)range replacementString:(NSString *)string {
    if (!string || [string isEqualToString:@""]) {
        return YES;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *filteredForJustNumbersString = [newString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    filteredForJustNumbersString = [filteredForJustNumbersString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    filteredForJustNumbersString = [filteredForJustNumbersString stringByReplacingOccurrencesOfString:@")" withString:@""];
    filteredForJustNumbersString = [filteredForJustNumbersString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([filteredForJustNumbersString rangeOfCharacterFromSet:notDigits].location != NSNotFound) {
        // newString does not consists onl of the digits 0 through 9
        return NO;
    }
    
    NSString *replacementString;
    if ([filteredForJustNumbersString length] >= 3) {
        replacementString = @"(";
        replacementString = [replacementString stringByAppendingString:[filteredForJustNumbersString substringWithRange:NSMakeRange(0, 3)]];
        replacementString = [replacementString stringByAppendingString:@") "];
        if ([filteredForJustNumbersString length] > 3) {
            replacementString = [replacementString stringByAppendingString:[filteredForJustNumbersString
                                                                            substringWithRange:NSMakeRange(3, MIN([filteredForJustNumbersString length] - 3, 3))]];
        }
    }
    if ([filteredForJustNumbersString length] >= 6) {
        replacementString = [replacementString stringByAppendingString:@"-"];
        if ([filteredForJustNumbersString length] > 6) {
            replacementString = [replacementString stringByAppendingString:[filteredForJustNumbersString
                                                                            substringWithRange:NSMakeRange(6, [filteredForJustNumbersString length] - 6)]];
        }
    }
    if ([replacementString length] > 14) {
        replacementString = [replacementString substringWithRange:NSMakeRange(0, 14)];
    }
    
    if (replacementString) {
        textField.text = replacementString;
        return NO;
    }
    return YES;
}



#pragma mark - Email

- (BOOL)validateEmailWithString:(NSString*)email
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.emailTextField.text length]==0 || [self validateEmailWithString:self.emailTextField.text]) {
        [textField resignFirstResponder];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter valid email address." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        [textField becomeFirstResponder];
        return NO;
    }
    return YES;
}



#pragma mark - Camera
- (IBAction)cameraPressed:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}





#pragma mark - DOB
-(void)updateTextField:(id)sender{
    NSLog(@"Original Date %@", self.dobTextField.text);
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy"];
    UIDatePicker *picker = (UIDatePicker*)self.dobTextField.inputView;
    self.dobTextField.text = [df stringFromDate:picker.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    self.dateOfBirth = [dateFormatter stringFromDate:picker.date];
    NSLog(@"%@",self.dateOfBirth);
}


         


#pragma mark - Saving data to cloud
- (IBAction)onSaveButtonPressed:(id *)sender {
    
    if (self.mrnTextField.text || self.firstNameTextField.text || self.lastNameTextField.text || self.emailTextField.text ||
        self.contactNumberTextField.text || [self.insuranceTextField.text  isEqual: @""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please complete all fields." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else{
        
        if (self.genderControl.selectedSegmentIndex == 0) {
            self.isMale = YES;
        }
        if (self.genderControl.selectedSegmentIndex == 1){
            self.isMale = NO;
        }
        
        
        self.mrn = self.mrnTextField.text;
        self.firstName =self.firstNameTextField.text;
        self.lastName = self.lastNameTextField.text;
        self.email = self.emailTextField.text;
        self.contactNumber = self.contactNumberTextField.text;
        self.insurance = self.insuranceTextField.text;
        
        NSLog(@"%@ %@ %@ %@ %d", self.firstName, self.email,self.contactNumber, self.dateOfBirth, self.isMale);
        
        
        
        
        //Fresh Post
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"https://adoctor.herokuapp.com/api/user"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        NSMutableDictionary *tmpJson = [NSMutableDictionary new];
        tmpJson[@"name"] = [NSString stringWithFormat:@"%@ %@",self.firstName, self.lastName];
        tmpJson[@"email"] = self.email;
        tmpJson[@"phoneNumber"] = self.contactNumber;
        tmpJson[@"birthdate"] = self.dateOfBirth;
        tmpJson [@"gender"] = [NSNumber numberWithBool:self.isMale];
        
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:tmpJson options:0 error:&error];
        NSLog(@"postData = %@", postData);
        
        [request setHTTPBody:postData];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                NSLog(@"requestReply: %@", requestReply);
            }] resume];
    }
}




#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}





#pragma Mark - Keyboard notification

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.view.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.view.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}




@end
