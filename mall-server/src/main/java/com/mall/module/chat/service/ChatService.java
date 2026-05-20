package com.mall.module.chat.service;

import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import java.util.List;
import java.util.Map;

public interface ChatService {
    List<Map<String, Object>> getConversations(Long userId);
    List<Message> getMessages(Long conversationId, int page, int size);
    Message sendMessage(Long senderId, Long conversationId, String content);
    Conversation getOrCreateConversation(Long buyerId, Long sellerId);
}
