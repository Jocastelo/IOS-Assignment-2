//
//  GameController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 28/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "GameController.h"



@interface GameController ()

@end

@implementation GameController

@synthesize user;

- (void)viewDidLoad {
    [self initView];
    [self ConfigureController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*Function initView
 *Description: initializer the view and settings information
 */
-(void) initView{
    
    [super viewDidLoad];
    if(self.settings == nil)
        self.settings = [[UserSettings alloc] init];
    [self.settings initSettings];
    
    NSString* remain_time = [self.settings getTimeSettings];
    NSString* max_bubbles = [self.settings getBubbluesSettings];
    self.score = 0;
    self.remain_time = (int)[remain_time integerValue];
    self.max_bubbles = (int)[max_bubbles integerValue];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(UpdateTime) userInfo:nil repeats:YES]; // initialize timer
    [self.timer fire]; // start timer
}

/*Function ConfigureController
 *Description: Register the notifications and create the bubbles array
 */
-(void)ConfigureController{
    [self registerNotifications];
    self.label_score.text = [NSString stringWithFormat:@"Score    %d",self.score];
    self.bubbles = [BubbleCollection CreateBubbles:self.max_bubbles withFrameX: self.view.frame.size.width withFrameY:self.view.frame.size.height];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"record"]){
        user.userscore = [NSString stringWithFormat:@"%d", self.score];
        RecordController* record = [segue destinationViewController];
        record.user = user;
        
    }
    
}

/* 
 *Function showRecords
 *Decription: Show the record screen
 */
-(void)showRecords{
    [self performSegueWithIdentifier:@"record" sender:nil];
}

/*Function Update_time
 *Description: This function execute at each second and update the time. When the time becomes 0, the function stop the timer and create a alert for users.
 */
-(void)UpdateTime{
    if(self.remain_time == 0){
        UIAlertController* alert = [self CreateAlert];
        self.label_timer.text = [NSString stringWithFormat:@"Time  %d", self.remain_time];
        [self.timer invalidate];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
        self.label_timer.text = [NSString stringWithFormat:@"Time  %d", self.remain_time];
        self.remain_time--;
        [BubbleCollection ChangeBubbles:self.bubbles withMAXBubbles:self.max_bubbles withFramewidht:self.view.frame.size.width withFrameheight:self.view.frame.size.height];
    }
}

/*Function registerNotification
 *Description: Register the notifications in the NSNotificationCenter.
 */
-(void) registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"ADD_BUBBLES"    object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"REMOVE_BUBBLE" object:nil];
    
}


/*Function receiveNotification
 *Description: Identify and execute the notifications.
 */
-(void) receiveNotification: (NSNotification *) notification{
    if([[notification name] isEqualToString:@"ADD_BUBBLES"]){
        [self addBubbles:notification.object];
    }
    else if([[notification name] isEqualToString:@"REMOVE_BUBBLE"]){
        [self RemoveBubbleWithAnimation:notification.object];
    }
    
}



/*Function addBubbles
 *Description: Receive a array of bubbles and add in the screen
 */
-(void) addBubbles: (NSMutableArray*) my_bubbles{
    Bubble * new_b = nil;
    for(int i = 0; i < [my_bubbles count]; i++){
        new_b = (Bubble*) my_bubbles[i];
        [new_b setFrame:CGRectMake(new_b.position_x, new_b.position_y, widthBubble, heightBubble)];
        [new_b addTarget:self action:@selector(playBubble:) forControlEvents:UIControlEventTouchUpInside];
        
        CGAffineTransform trans = CGAffineTransformScale(new_b.transform, 0.01, 0.01);
        new_b.transform = trans;
        [self.view addSubview: new_b];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            new_b.transform  = CGAffineTransformScale(new_b.transform, 100.0, 100.0);
             }completion:nil];
        
    }
}


/*Function RemoveBubblesWithAnimation
 *Description: Receive a array of bubbles and remove the bubbles present in that array of the screen.
 */
-(void) RemoveBubbleWithAnimation: (Bubble *) bubble{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         bubble.transform = CGAffineTransformScale(bubble.transform, 0.01, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [bubble removeFromSuperview];
                     }];
}

/*Function RemoveBubblesWithAnimation
 *Input: last point and the current point 
 *Description: Calculate the score following the CF6
 */
-(void)CalculeScore: (int) last_point withCurrentPoint: (int) current_point{
    if(last_point == current_point){
        float score = ((float) current_point)*1.5;
        self.score += ((int)score);
    }
    else{
        self.score += current_point;
        self.last_bubble = current_point;
    }
}

/*Function CreateAlert
 *Output: UIAlertController informing users about Game Over.
 */
-(UIAlertController *) CreateAlert{
    UIAlertController* new_alert = [UIAlertController alertControllerWithTitle:@"GAME OVER"
                                                                       message:@"You was great!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        //Do some thing here
                                        [self showRecords];
                                        
                                    }];

    
    [new_alert addAction:defaultAction];
    
    return new_alert;
    
}

/*Remove bubble and update score*/
- (IBAction)playBubble:(id)sender {
    Bubble *b = (Bubble*) sender;
    [self CalculeScore:self.last_bubble withCurrentPoint:b.pointBubble];
    self.label_score.text = [NSString stringWithFormat:@"Score    %d",self.score];
    [BubbleCollection RemoveBubbles:b in:self.bubbles];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
