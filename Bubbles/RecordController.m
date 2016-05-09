//
//  RecordController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 8/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "RecordController.h"

@interface RecordController ()

@end

@implementation RecordController

@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self rank];
    //[self.user saveData];   // Do any additional setup after loading the view.
}
-(void) rank{
    NSString * player_name = [[NSUserDefaults standardUserDefaults] objectForKey: @"first_player_name"];
    NSString * player_score = [[NSUserDefaults standardUserDefaults] objectForKey:@"first_player_score"];
    if(player_name == nil){
        [[NSUserDefaults standardUserDefaults] setObject:self.user.username  forKey:@"first_player_name"];
        [[NSUserDefaults standardUserDefaults] setObject:self.user.userscore forKey:@"first_player_score"];
        self.first_name.text = self.user.username;
        self.first_score.text = self.user.userscore;
    }
    else{
        self.first_name.text = player_name;
        self.first_score.text = player_score;
        NSLog(@"I am here");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
