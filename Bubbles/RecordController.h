//
//  RecordController.h
//  Bubbles
//
//  Created by Joao Victor Castelo on 8/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface RecordController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *RecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *first_name;
@property (weak, nonatomic) IBOutlet UILabel *second_name;
@property (weak, nonatomic) IBOutlet UILabel *third_name;
@property (weak, nonatomic) IBOutlet UILabel *first_score;
@property (weak, nonatomic) IBOutlet UILabel *second_score;
@property (weak, nonatomic) IBOutlet UILabel *third_score;

@property User* user;
@end
