//
//  ViewController.h
//  Instagramish2
//
//  Created by Marcial Galang on 2/4/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface ViewController : PFQueryTableViewController
@property (nonatomic, retain) PFFile *file;
@end
