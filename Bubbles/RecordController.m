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
    [self initRecordView];
    [self showBest];
    //[self.user saveData];   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showBest{
    NSString * player_name = [[NSUserDefaults standardUserDefaults] objectForKey: @"first_player_name"];
    NSString * player_score = [[NSUserDefaults standardUserDefaults] objectForKey:@"first_player_score"];
    if(player_name == nil || [self.user.userscore integerValue] > [player_score integerValue]){
        [[NSUserDefaults standardUserDefaults] setObject:self.user.username  forKey:@"first_player_name"];
        [[NSUserDefaults standardUserDefaults] setObject:self.user.userscore forKey:@"first_player_score"];
        self.first_name.text = self.user.username;
        self.first_score.text = self.user.userscore;
    }
    else{
        self.first_name.text = player_name;
        self.first_score.text = player_score;
    }
}


-(void)initRecordView{
    [super viewDidLoad];
     if(self.best_players == nil)
         self.best_players = [[NSMutableArray alloc] init];
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
