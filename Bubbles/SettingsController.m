//
//  SettingsController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 28/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *timer_options;
@property (weak, nonatomic) IBOutlet UISlider *bubbles_option;
@property (weak, nonatomic) IBOutlet UILabel *bubbles_label;
@property (weak, nonatomic) IBOutlet UIButton *save_button;
@end

@implementation SettingsController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.settings = [[UserSettings alloc] init];
    [self.settings initSettings];
    [self LoadSettingsInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


/*Function LoadSettingsInformation
 *Description: Load the settings information. If the settings information = nil, the function will initialize with the default values
 */
- (void)LoadSettingsInformation{
   
    NSString* num_bubbles = [self.settings getBubbluesSettings];
    self.bubbles_label.text = num_bubbles;
    self.bubbles_option.value = (float) [num_bubbles integerValue];
    
    int timer_segment = [self.settings getTimesegment:[[NSUserDefaults standardUserDefaults] valueForKey:@"settings_time"]];
    [self.timer_options setSelectedSegmentIndex:timer_segment];
}

/*Return for the previously screen*/
- (IBAction)SaveSettings:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*Set time settings*/
- (IBAction)ChooseTimer:(id)sender {
    UISegmentedControl* timer_control = (UISegmentedControl*) sender;
    NSString* string_timer = [timer_control titleForSegmentAtIndex:[timer_control selectedSegmentIndex]];
    [self.settings setTimeSettings:string_timer];
}

/*Set bubbles settings*/
- (IBAction)ChooseBubbles:(id)sender {
    UISlider* slider = (UISlider *) sender;
    self.bubbles_label.text = [NSString stringWithFormat:@"%d", (int) slider.value];
    [self.settings setBubbluesSettings:self.bubbles_label.text];
    //[[NSUserDefaults standardUserDefaults] setValue:self.bubbles_label.text forKey:@"settings_bubbles"];
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