
//  CZPlaceholderTextView.m
//  Caremobile
//
//  Created by Victor Ilyukevich on 4/8/15.
//  Copyright (c) 2015 Care Zone Inc. All rights reserved.
//

#import "CZPlaceholderTextView.h"

@interface CZPlaceholderTextView ()
@property(nonatomic,readonly) BOOL hasPlaceholderLabel;
@property(nonatomic,strong) UILabel *placeholderLabel;
@end

@implementation CZPlaceholderTextView

#pragma mark - Getters

- (BOOL)hasPlaceholderLabel
{
  return (_placeholderLabel != nil);
}

- (NSString *)placeholder
{
  return self.placeholderLabel.text;
}

- (UILabel *)placeholderLabel
{
  if (_placeholderLabel == nil) {
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0.098 alpha:0.22];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    if (self.font == nil && self.text.length == 0) {
      // `self.font` returns nil before any text was set to the text view.
      self.text = @"a";
      self.text = nil;
    }
    _placeholderLabel.font = self.font;
    _placeholderLabel.hidden = YES;
    _placeholderLabel.numberOfLines = 0;

    [self insertSubview:_placeholderLabel atIndex:0];
  }

  return _placeholderLabel;
}

#pragma mark - Setters

- (void)setPlaceholder:(NSString *)placeholder
{
  self.placeholderLabel.text = placeholder;
  [self updatePlaceholderLabelVisibilityIfNeeded];
  [self setNeedsLayout];
  [self setNeedsUpdateConstraints];
}

#pragma mark - Methods

- (void)layoutPlaceholderLabel
{
  CGPoint startingPoint = [self firstRectForRange:nil].origin;
  CGFloat horizontalPadding = startingPoint.x;
  CGFloat verticalPadding = startingPoint.y;

  CGFloat maxWidthForLabel = CGRectGetWidth(self.bounds) - horizontalPadding * 2;
  CGFloat maxHeightForLabel = CGRectGetHeight(self.bounds) - verticalPadding * 2;
  CGSize sizeThatFits = [self.placeholderLabel sizeThatFits:CGSizeMake(maxWidthForLabel, maxHeightForLabel)];

  CGRect rect = CGRectZero;
  rect.origin = startingPoint;
  rect.size.height = MIN(maxHeightForLabel, sizeThatFits.height);
  rect.size.width = MIN(maxWidthForLabel, sizeThatFits.width);

  self.placeholderLabel.frame = rect;
}

- (void)updatePlaceholderLabelVisibilityIfNeeded
{
  if (self.hasPlaceholderLabel) {
    BOOL shouldBeHidden = (self.text.length > 0);
    if (self.placeholderLabel.isHidden != shouldBeHidden) {
      self.placeholderLabel.hidden = shouldBeHidden;
      [self setNeedsLayout];
    }
  }
}

#pragma mark - UITextInput

- (UITextRange *)markedTextRange
{
  [self updatePlaceholderLabelVisibilityIfNeeded];
  return [super markedTextRange];
}

- (UITextRange *)selectedTextRange
{
  [self updatePlaceholderLabelVisibilityIfNeeded];
  return [super selectedTextRange];
}

#pragma mark - UITextView

- (void)setFont:(UIFont *)font
{
  super.font = font;
  if (self.hasPlaceholderLabel) {
    self.placeholderLabel.font = font;
  }
}

- (void)setText:(NSString *)text
{
  super.text = text;
  [self updatePlaceholderLabelVisibilityIfNeeded];
}

#pragma mark - UIView

- (void)layoutSubviews
{
  [super layoutSubviews];

  if (self.hasPlaceholderLabel && self.text.length == 0) {
    [self layoutPlaceholderLabel];
  }
}

- (CGSize)sizeThatFits:(CGSize)size
{
  CGSize defaultSizeThatFits = [super sizeThatFits:size];

  if (self.hasPlaceholderLabel == NO) {
    return defaultSizeThatFits;
  }

  CGSize placeholderSize = [self.placeholderLabel sizeThatFits:size];

  CGPoint startingPoint = [self firstRectForRange:nil].origin;
  CGFloat horizontalPadding = startingPoint.x;
  CGFloat verticalPadding = startingPoint.y;

  placeholderSize.width += horizontalPadding * 2;
  placeholderSize.height += verticalPadding * 2;

  CGSize result = CGSizeZero;
  result.width = MAX(placeholderSize.width, defaultSizeThatFits.width);
  result.height = MAX(placeholderSize.height, defaultSizeThatFits.height);
  return result;
}

@end
