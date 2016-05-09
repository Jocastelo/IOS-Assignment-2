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
    
    /*
    Bubble * test = [Bubble alloc];
    test = [test initBubble:@"Black" with:40 withX:0 withY:self.view.frame.size.height-60];
    [test setFrame:CGRectMake(test.position_x, test.position_y, widthBubble, heightBubble)];
    [self.view addSubview: test];
    NSLog(@"position %f %f", test.position_x, test.position_y);
    */
    
}

-(void) initView{
    if(self.settings == nil)
        self.settings = [[UserSettings alloc] init];
    [super viewDidLoad];
    [self.settings initSettings];
    
    NSString* remain_time = [[NSUserDefaults standardUserDefaults] valueForKey:@"settings_time"];
    NSString* max_bubbles = [[NSUserDefaults standardUserDefaults] valueForKey:@"settings_bubbles"];
    self.score = 0;
    self.remain_time = (int)[remain_time integerValue];
    self.max_bubbles = (int)[max_bubbles integerValue];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(UpdateTime) userInfo:nil repeats:YES];
    [self.timer fire];
}

/*Controller Methods*/
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

-(void)showRecords{
    [self performSegueWithIdentifier:@"record" sender:nil];
}
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

-(void) registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"ADD_BUBBLES"    object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"REMOVE_BUBBLE" object:nil];
    
}

-(void) receiveNotification: (NSNotification *) notification{
    if([[notification name] isEqualToString:@"ADD_BUBBLES"]){
        [self addBubbles:notification.object];
    }
    else if([[notification name] isEqualToString:@"REMOVE_BUBBLE"]){
        [self RemoveBubbleWithAnimation:notification.object];
    }
    
}
//Controller

//Notifications Methods
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

-(void) RemoveBubbleWithAnimation: (Bubble *) bubble{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         bubble.transform = CGAffineTransformScale(bubble.transform, 0.01, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [bubble removeFromSuperview];
                     }];
    
    //[BubbleCollection PrintArray:self.bubbles];
}
//Notification Methods

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

- (IBAction)playBubble:(id)sender {
    Bubble *b = (Bubble*) sender;
    [self CalculeScore:self.last_bubble withCurrentPoint:b.pointBubble];
    self.label_score.text = [NSString stringWithFormat:@"Score    %d",self.score];
    [BubbleCollection RemoveBubbles:b in:self.bubbles];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
