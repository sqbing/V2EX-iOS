//
//  V2EXNormalModel.m
//  V2EX
//
//  Created by WildCat on 2/8/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import "V2EXNormalModel.h"
#import "JSONAPIURI.h"

@implementation V2EXNormalModel

- (void)getIndex {
    [self getHTMLData:@"" parameters:nil];
}

- (void)getTopicsList:(NSString *)URI {
    [self getHTMLData:[@"go/" stringByAppendingString:URI] parameters:nil];
}

//- (void)getTopicWithLinkURI:(NSString *)URI {
//    [self getHTMLData:[URI stringByReplacingOccurrencesOfString:@"/t/" withString:@"t/"] parameters:nil];
//}


// User
- (void)getUserInfo:(NSString *)username {
    [self getHTMLData:[NSString stringWithFormat:@"member/%@", username] parameters:nil];
}

- (void)getUserTopics:(NSString *)username {
    [self getHTMLData:[NSString stringWithFormat:@"member/%@/topics", username] parameters:nil];
}

- (void)getUserReplies:(NSString *)username {
    [self getHTMLData:[NSString stringWithFormat:@"member/%@/replies", username] parameters:nil];
}


// JSON API
- (void)getLatestTopics {
    [self getJSONData:TOPICS_LATEST parameters:nil];
}

- (void)getAllNodes {
    [self getJSONData:NODES_ALL parameters:nil];
}

// Topic
- (void)getTopicWithID:(NSUInteger)ID {
    [self getHTMLData:[NSString stringWithFormat:@"t/%i", (unsigned int)ID] parameters:nil];
}

- (void)replyTopic:(NSUInteger)topicID andOnce:(NSUInteger)onceCode andContent:(NSString *)content {
    [self postData:[NSString stringWithFormat:@"t/%i", topicID] parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", onceCode], @"once", content, @"content", nil]];
}

- (void)getNewTopicPage:(NSString *)uri {
    [self getHTMLData:[NSString stringWithFormat:@"new/%@", uri]  parameters:nil];
}

- (void)newTopic:(NSString *)uri andTitle:(NSString *)title andContent:(NSString *)content andOnce:(NSUInteger)once {
    [self postData:[NSString stringWithFormat:@"new/%@", uri] parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", once], @"once", title, @"title", content, @"content", nil]];
}

- (void)reportTopic:(NSUInteger)topicID {
    NSUInteger time = [[NSDate date] timeIntervalSince1970];
    [self getHTMLData:[NSString stringWithFormat:@"report/topic/%i?t=%i", topicID, time] parameters:nil];
}


@end
