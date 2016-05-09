//
//  GameController.h
//  Bubbles
//
//  Created by Joao Victor Castelo on 28/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleCollection.h"
#import "Bubble.h"
#import "User.h"
#import "RecordController.h"
#import "UserSettings.h"

@interface GameController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label_score;
@property (weak, nonatomic) IBOutlet UILabel *label_timer;
@property (strong, nonatomic) NSMutableArray* bubbles;
@property int score;
@property int remain_time;
@property int max_bubbles;
@property int last_bubble;
@property NSTimer* timer;
@property User* user;
@property UserSettings* settings;
-(void) receiveNotification: (NSNotification *) notification;
@end
