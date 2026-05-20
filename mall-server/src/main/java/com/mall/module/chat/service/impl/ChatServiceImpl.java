package com.mall.module.chat.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mall.common.BusinessException;
import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import com.mall.module.chat.mapper.ConversationMapper;
import com.mall.module.chat.mapper.MessageMapper;
import com.mall.module.chat.service.ChatService;
import com.mall.module.user.entity.User;
import com.mall.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {
    private final ConversationMapper conversationMapper;
    private final MessageMapper messageMapper;
    private final UserService userService;

    @Override
    public List<Map<String, Object>> getConversations(Long userId) {
        List<Conversation> convs = conversationMapper.selectList(new LambdaQueryWrapper<Conversation>()
                .and(w -> w.eq(Conversation::getBuyerId, userId)
                        .or().eq(Conversation::getSellerId, userId))
                .orderByDesc(Conversation::getLastMessageTime));
        if (convs.isEmpty()) return Collections.emptyList();

        Set<Long> peerIds = new HashSet<>();
        for (Conversation c : convs) {
            peerIds.add(c.getBuyerId().equals(userId) ? c.getSellerId() : c.getBuyerId());
        }
        Map<Long, User> userMap = userService.getUserMap(peerIds);

        List<Map<String, Object>> result = new ArrayList<>();
        for (Conversation c : convs) {
            Long peerId = c.getBuyerId().equals(userId) ? c.getSellerId() : c.getBuyerId();
            User peer = userMap.get(peerId);
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("id", c.getId());
            m.put("buyerId", c.getBuyerId());
            m.put("sellerId", c.getSellerId());
            m.put("peerId", peerId);
            m.put("peerName", peer != null ? peer.getUsername() : "Unknown");
            m.put("lastMessage", c.getLastMessage());
            m.put("lastMessageTime", c.getLastMessageTime());
            result.add(m);
        }
        return result;
    }

    @Override
    public List<Message> getMessages(Long conversationId, int page, int size) {
        return messageMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Message>()
                        .eq(Message::getConversationId, conversationId)
                        .orderByDesc(Message::getCreatedAt)).getRecords();
    }

    @Override
    public Message sendMessage(Long senderId, Long conversationId, String content) {
        Conversation conv = conversationMapper.selectById(conversationId);
        if (conv == null) throw new BusinessException("Conversation not found");
        if (!conv.getBuyerId().equals(senderId) && !conv.getSellerId().equals(senderId))
            throw new BusinessException("Not in this conversation");
        Message msg = new Message();
        msg.setConversationId(conversationId);
        msg.setSenderId(senderId);
        msg.setContent(content);
        msg.setType("TEXT");
        msg.setIsRead(0);
        messageMapper.insert(msg);
        conv.setLastMessage(content);
        conv.setLastMessageTime(LocalDateTime.now());
        conversationMapper.updateById(conv);
        return msg;
    }

    @Override
    public Conversation getOrCreateConversation(Long buyerId, Long sellerId) {
        Conversation conv = conversationMapper.selectOne(new LambdaQueryWrapper<Conversation>()
                .eq(Conversation::getBuyerId, buyerId)
                .eq(Conversation::getSellerId, sellerId));
        if (conv == null) {
            conv = new Conversation();
            conv.setBuyerId(buyerId);
            conv.setSellerId(sellerId);
            conversationMapper.insert(conv);
        }
        return conv;
    }
}
