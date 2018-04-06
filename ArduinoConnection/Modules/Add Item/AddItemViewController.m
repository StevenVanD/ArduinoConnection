//
//  addItemViewController.m
//  ArduinoConnection
//
//  Created by Steven Van Durm on 6/04/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddItemViewController.h"

@interface AddItemViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel1;

@end


@implementation AddItemViewController
    
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
}
- (IBAction)changeditemNametextField:(UITextField *)sender {
    _testLabel1.text = sender.text;
}
    
@end
