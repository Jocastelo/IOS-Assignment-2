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


- (void)viewDidLoad {
    [super viewDidLoad];
    alert = [self CreateAlert];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Send the user information for the GameController
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"game"]){
        User* user = [[User alloc] initUser];
        user.username = self.username.text;
        GameController* game = [segue destinationViewController];
        game.user = user;
        
    }
    
}


/*Function CreateAlert
 *Output: UIAlertController informing users about invalid usernames.
 */
-(UIAlertController *) CreateAlert{
    UIAlertController* new_alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                        message:@"Invalid name. Please inform the user name before start."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [new_alert addAction:defaultAction];
    
    return new_alert;
    
}

/*Button action show alert in case of invalid name. Show game_screen otherwise */
- (IBAction)playButton:(id)sender {
    if([self.username.text isEqualToString:@""]){
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        [self performSegueWithIdentifier:@"game" sender:nil];
    }
}

/*Show settings_screen */
- (IBAction)settingsAction:(id)sender {
}

/*Change the button volume icon.
 *The sound functions was not implemented.
 */
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
