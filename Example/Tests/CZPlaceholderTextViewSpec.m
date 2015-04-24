//
//  CZPlaceholderTextViewSpec.m
//  CZPlaceholderTextViewspec
//
//  Created by Victor Ilyukevich on 04/18/2015.
//  Copyright (c) 2014 Victor Ilyukevich. All rights reserved.
//

#import <CZPlaceholderTextView/CZPlaceholderTextView.h>

SpecBegin(CZPlaceholderTextView)

describe(@"CZPlaceholderTextView", ^{
  context(@"when initialized", ^{
    __block CZPlaceholderTextView *textView;

    beforeEach(^{
      textView = [[CZPlaceholderTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    });

    it(@"can set and read placeholder", ^{
      expect(textView.placeholder).to.beNil();
      textView.placeholder = @"Lorem ipsum dolor sit amet.";
      expect(textView.placeholder).to.equal(@"Lorem ipsum dolor sit amet.");
    });

    context(@"with very long placeholder", ^{
      beforeEach(^{
        textView.placeholder = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla lobortis felis a mattis vehicula. Suspendisse sollicitudin interdum ipsum, eu venenatis nisi malesuada vel.";
      });

      it(@"has multiline placeholder", ^{
        expect(textView).to.haveValidSnapshot();
      });

      it(@"truncates the placeholder when there is no enough space", ^{
        textView.frame = CGRectMake(0, 0, 180, 30);
        expect(textView).to.haveValidSnapshot();
      });

      describe(@"#sizeThatFits:", ^{
        it(@"provides right size to fit the entire placeholder", ^{
          CGRect frame = CGRectZero;
          frame.size = [textView sizeThatFits:CGSizeMake(90, MAXFLOAT)];
          textView.frame = frame;
          expect(textView).to.haveValidSnapshot();
        });

        it(@"returns size enough to fit entire placeholder even when there is short text in", ^{
          textView.text = @"Something short.";

          CGRect frame = CGRectZero;
          frame.size = [textView sizeThatFits:CGSizeMake(90, MAXFLOAT)];
          textView.frame = frame;
          expect(textView).to.haveValidSnapshot();
        });

        it(@"returns size enough to fit longer text if needed", ^{
          textView.text = [NSString stringWithFormat:@"%@ %@", textView.placeholder, textView.placeholder];

          CGRect frame = CGRectZero;
          frame.size = [textView sizeThatFits:CGSizeMake(90, MAXFLOAT)];
          textView.frame = frame;
          expect(textView).to.haveValidSnapshot();
        });
      });
    });
  });

  context(@"when comparing with `text`", ^{
    __block UIView *container;
    __block CZPlaceholderTextView *firstTextView;
    __block CZPlaceholderTextView *secondTextView;

    beforeEach(^{
      container = [[UIView alloc] initWithFrame:CGRectZero];
      container.backgroundColor = [UIColor lightGrayColor];
      firstTextView = [[CZPlaceholderTextView alloc] initWithFrame:CGRectZero];
      secondTextView = [[CZPlaceholderTextView alloc] initWithFrame:CGRectZero];
      [container addSubview:firstTextView];
      [container addSubview:secondTextView];
    });

    it(@"looks similar with and without placeholder", ^{
      container.frame = CGRectMake(0, 0, 320, 215);
      firstTextView.frame = CGRectMake(5, 5, 310, 100);
      secondTextView.frame = CGRectMake(5, 110, 310, 100);

      firstTextView.placeholder = @"Curabitur finibus eleifend quam at semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam, dolor vitae luctus pretium, lorem lectus aliquam ante, sed semper sapien enim non eros. ";
      secondTextView.text = firstTextView.placeholder;
      expect(container).to.haveValidSnapshot();
    });

    it(@"truncates long placeholder", ^{
      container.frame = CGRectMake(0, 0, 320, 75);
      firstTextView.frame = CGRectMake(5, 5, 310, 30);
      secondTextView.frame = CGRectMake(5, 40, 310, 30);

      firstTextView.placeholder = @"Curabitur finibus eleifend quam at semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam, dolor vitae luctus pretium, lorem lectus aliquam ante, sed semper sapien enim non eros. ";
      secondTextView.text = firstTextView.placeholder;
      expect(container).to.haveValidSnapshot();
    });
  });
});

SpecEnd
