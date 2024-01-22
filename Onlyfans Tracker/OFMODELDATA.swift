//
//  OFMODELDATA.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/21/24.
//

import Foundation




struct OnlyFansProfile: Codable {
    let name: String
    let username: String
    let photosCount: Int
    let videosCount: Int
    let favoritesCount: Int
    let id: Int
    let canLookStory: Bool
    let canCommentStory: Bool
    let hasNotViewedStory: Bool
    let isVerified: Bool
    let canPayInternal: Bool
    let hasScheduledStream: Bool
    let hasStream: Bool
    let hasStories: Bool
    let tipsEnabled: Bool
    let tipsTextEnabled: Bool
    let tipsMin: Int
    let tipsMinInternal: Int
    let tipsMax: Int
    let canEarn: Bool
    let canAddSubscriber: Bool
    let subscribePrice: Double
    let audiosCount: Int
    let mediasCount: Int
    let lastSeen: String
    let subscriptionBundles: [SubscriptionBundle]

    // Additional properties
    let location: String
    let postsCount: Int
    let archivedPostsCount: Int
    let privateArchivedPostsCount: Int
  
  

    // New properties
  
    let favoritedCount: Int
    let showPostsInFeed: Bool
    let canReceiveChatMessage: Bool
    let isPerformer: Bool
    let isRealPerformer: Bool
    let isSpotifyConnected: Bool
    let subscribersCount: Int?
    let hasPinnedPosts: Bool
    let canChat: Bool
    let callPrice: Double
    let isPrivateRestriction: Bool
    let showSubscribersCount: Bool
    let showMediaCount: Bool
    let canCreatePromotion: Bool
    let canCreateTrial: Bool
    let isAdultContent: Bool
    let canTrialSend: Bool
    let hasLinks: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, username, canLookStory, canCommentStory, hasNotViewedStory, isVerified, canPayInternal, hasScheduledStream, hasStream, hasStories, tipsEnabled, tipsTextEnabled, tipsMin, tipsMinInternal, tipsMax, canEarn, canAddSubscriber, subscribePrice, subscriptionBundles, location, postsCount, archivedPostsCount, privateArchivedPostsCount, photosCount, videosCount, audiosCount, mediasCount, lastSeen, favoritesCount, favoritedCount, showPostsInFeed, canReceiveChatMessage, isPerformer, isRealPerformer, isSpotifyConnected, subscribersCount, hasPinnedPosts, canChat, callPrice, isPrivateRestriction, showSubscribersCount, showMediaCount, canCreatePromotion, canCreateTrial, isAdultContent, canTrialSend, hasLinks
    }
}

struct SubscriptionBundle: Codable {
    let id: Int
    let discount: Int
    let duration: Int
    let price: Double
    let canBuy: Bool
}
