//
//  ViewController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 23/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "GameController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *volumeButton;
@property (weak, nonatomic) IBOutlet UITextField *username;


@end

@implementation ViewController
bool ismute = false;
UIAlertController* alert;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"game"]){
        User* user = [[User alloc] initUser];
        user.username = self.username.text;
        GameController* game = [segue destinationViewController];
        game.user = user;
        
    }
    
}
-(UIAlertController *) CreateAlert{
    UIAlertController* new_alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                        message:@"Invalid name. Please inform the user name before start."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [new_alert addAction:defaultAction];
    
    return new_alert;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    alert = [self CreateAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButton:(id)sender {
    if([self.username.text isEqualToString:@""]){
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        [self performSegueWithIdentifier:@"game" sender:nil];
    }
}
- (IBAction)settingsAction:(id)sender {
    //[self performSegueWithIdentifier:@"settings" sender:nil];
}
- (IBAction)volumesAction:(id)sender {
    if(ismute == false){
    [_volumeButton setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
        ismute = true;
    }
    else{
        [_volumeButton setImage:[UIImage imageNamed:@"volume.ico"] forState:UIControlStateNormal];
        ismute = false;
    }
}

@end
