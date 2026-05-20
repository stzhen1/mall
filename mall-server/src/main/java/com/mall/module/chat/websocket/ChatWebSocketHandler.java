package com.mall.module.chat.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import com.mall.module.chat.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
@RequiredArgsConstructor
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final ChatService chatService;
    private final ObjectMapper objectMapper;
    private final Map<Long, WebSocketSession> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Long userId = (Long) session.getAttributes().get("userId");
        if (userId != null) {
            sessions.put(userId, session);
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {
        Long senderId = (Long) session.getAttributes().get("userId");
        String senderRole = (String) session.getAttributes().get("role");
        if (senderId == null) return;

        Map<String, Object> payload = objectMapper.readValue(textMessage.getPayload(), Map.class);
        Long receiverId = Long.valueOf(payload.get("receiverId").toString());
        String content = payload.get("content").toString();

        boolean isBuyer = "BUYER".equals(senderRole);
        Long buyerId = isBuyer ? senderId : receiverId;
        Long sellerId = isBuyer ? receiverId : senderId;

        Conversation conv = chatService.getOrCreateConversation(buyerId, sellerId);
        Message msg = chatService.sendMessage(senderId, conv.getId(), content);

        Map<String, Object> response = Map.of(
                "id", msg.getId(),
                "conversationId", conv.getId(),
                "senderId", senderId,
                "receiverId", receiverId,
                "content", content,
                "type", msg.getType(),
                "createdAt", msg.getCreatedAt() != null ? msg.getCreatedAt().toString() : LocalDateTime.now().toString()
        );

        String json = objectMapper.writeValueAsString(response);
        session.sendMessage(new TextMessage(json));

        WebSocketSession receiverSession = sessions.get(receiverId);
        if (receiverSession != null && receiverSession.isOpen()) {
            receiverSession.sendMessage(new TextMessage(json));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Long userId = (Long) session.getAttributes().get("userId");
        if (userId != null) {
            sessions.remove(userId);
        }
    }
}
