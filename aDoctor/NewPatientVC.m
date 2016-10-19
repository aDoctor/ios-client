//
//  NewPatientVC.m
//  aDoctor
//
//  Created by David Iskander on 10/2/16.
//  Copyright © 2016 David Iskander. All rights reserved.
//

#import "NewPatientVC.h"

@interface NewPatientVC ()<UINavigationControllerDelegate, UITextFieldDelegate, NSURLConnectionDelegate, UIImagePickerControllerDelegate>
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
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;

@property NSString *mrn;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property NSString *contactNumber;
@property NSString *dob;
@property NSString *gender;
@property NSString *insurance;

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
    self.genderTextField.delegate = self;
    self.insuranceTextField.delegate = self;
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


#pragma mark - Saving data to cloud
- (IBAction)onSaveButtonPressed:(id *)sender {
    self.mrn = self.mrnTextField.text;
    self.firstName =self.firstNameTextField.text;
    self.lastName = self.lastNameTextField.text;
    self.email = self.emailTextField.text;
    self.contactNumber = self.contactNumberTextField.text;
    self.dob = self.dobTextField.text;
    self.gender = self.genderTextField.text;
    self.insurance = self.insuranceTextField.text;
    
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:@"https://adoctor.herokuapp.com/api/user"]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@", self.mrn, self.firstName, self.lastName, self.email, self.contactNumber, self.dob, self.gender, self.insurance];
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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



@end
