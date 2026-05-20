package com.mall.module.chat.controller;

import com.mall.common.Result;
import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import com.mall.module.chat.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {
    private final ChatService chatService;

    @GetMapping("/conversations")
    public Result<List<Map<String, Object>>> conversations(Authentication auth) {
        return Result.ok(chatService.getConversations(Long.valueOf(auth.getName())));
    }

    @GetMapping("/messages/{convId}")
    public Result<List<Message>> messages(@PathVariable Long convId,
                                           @RequestParam(defaultValue = "1") int page,
                                           @RequestParam(defaultValue = "50") int size) {
        return Result.ok(chatService.getMessages(convId, page, size));
    }

    @PostMapping("/conversation")
    public Result<Conversation> getOrCreateConversation(@RequestBody Map<String, Long> body) {
        return Result.ok(chatService.getOrCreateConversation(body.get("buyerId"), body.get("sellerId")));
    }

    @PostMapping("/messages")
    public Result<Message> sendMessageRest(Authentication auth, @RequestBody Map<String, Object> body) {
        Long senderId = Long.valueOf(auth.getName());
        Long receiverId = Long.valueOf(body.get("receiverId").toString());
        String content = body.get("content").toString();
        boolean isBuyer = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_BUYER"));
        Long buyerId = isBuyer ? senderId : receiverId;
        Long sellerId = isBuyer ? receiverId : senderId;
        Conversation conv = chatService.getOrCreateConversation(buyerId, sellerId);
        return Result.ok(chatService.sendMessage(senderId, conv.getId(), content));
    }
}
