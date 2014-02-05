//
//  ViewController.m
//  Instagramish2
//
//  Created by Marcial Galang on 2/4/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "ViewController.h"
#import "Parse/Parse.h"
#import "PhotoTableViewCell.h"

@interface ViewController () <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    PFLogInViewController *login;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Curret user is = %@",[PFUser currentUser]);
}

-(void)viewDidAppear:(BOOL)animated
{
    if (![PFUser currentUser]) {
        login = [PFLogInViewController new];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        login.signUpController.delegate = self;
        login.delegate = self;
        label.text = @"Instagramish Login";
        [label sizeToFit];
        login.logInView.logo = label;
        [self presentViewController:login animated:YES completion:nil];
        NSLog(@"Curret user is = %@",[PFUser currentUser]);
    }
}
-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:NO completion:nil];
    [login dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [login dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)onAddPhotoButonPressed:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{}];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{}];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    PFObject *image = [PFObject objectWithClassName:@"Image"];
    image[@"imageName"] = [NSString stringWithFormat:@"%.10u",arc4random()];
    image[@"user"] = [PFUser currentUser][@"username"];
    image[@"imageFile"]= UIImagePNGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"]);
    [image saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
