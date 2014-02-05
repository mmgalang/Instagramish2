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
    self.parseClassName = @"Image";
    
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
    
    NSData *imageData = UIImagePNGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"]);
    PFFile *imageFile = [PFFile fileWithData:imageData ];
    image[@"imageFile"] = imageFile;
    [image saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}


-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    self.tableView.rowHeight=380;
    PhotoTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    PFFile *file = [object objectForKey: @"imageFile"];
    cell.imageView.file = file;
    [cell.imageView loadInBackground];
    cell.textLabel.text = [NSString stringWithFormat:@" Life: as seen through the eyes of %@",[object objectForKey:@"user"]];
    return cell;
}

@end
