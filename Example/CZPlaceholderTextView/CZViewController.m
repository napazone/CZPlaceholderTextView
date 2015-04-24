//
//  CZViewController.m
//  CZPlaceholderTextView
//
//  Created by Victor Ilyukevich on 04/18/2015.
//  Copyright (c) 2014 Victor Ilyukevich. All rights reserved.
//

#import "CZViewController.h"
#import <CZPlaceholderTextView/CZPlaceholderTextView.h>

@interface CZViewController ()
@property(nonatomic,weak) IBOutlet CZPlaceholderTextView *smallTextView;
@property(nonatomic,weak) IBOutlet UITextField *textField;
@property(nonatomic,weak) IBOutlet CZPlaceholderTextView *textView;
@end

@implementation CZViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.textView.placeholder = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ornare auctor varius. Duis euismod neque in velit sodales dictum sit amet vel tortor. Maecenas rhoncus metus ut libero vehicula, ut gravida mi ullamcorper. Curabitur egestas pellentesque enim quis pretium. In hac habitasse platea dictumst. Nulla facilisi. Integer nisl quam, rhoncus in libero id, consectetur lobortis metus.";

  self.smallTextView.placeholder = self.textView.placeholder;

  NSLog(@"UITextField uses internally:\n\tFont: %@\n\tText color: %@", [self.textField valueForKeyPath:@"_placeholderLabel.font"], [self.textField valueForKeyPath:@"_placeholderLabel.textColor"]);
}

@end
