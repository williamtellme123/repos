/*
package services;

import database.DatabaseClass;
import model.Message;

import java.util.*;

// CONSIDER THE BACKEND SERVICES
public class MessageServiceOriginal {

    private Map<Long,Message> messages = DatabaseClass.getMessages();

    public MessageServiceOriginal() {
        messages.put(1L, new Message(1, "Hokums Pokums", new Date(), "Billy"));
        messages.put(2L, new Message(2, "Frikas Frekus", new Date(), "Ellie"));
        messages.put(3L, new Message(3, "Whos there", new Date(), "Ellie"));
        messages.put(4L, new Message(4, "Plpay croquette", new Date(), "Billy"));
        messages.put(5L, new Message(5, "Anyone Home", new Date(), "Ellie"));
    }

    public List<Message> getAllMessages(){
        
        return new ArrayList<Message>(messages.values());
    }


    public Message getMessage(long id){

        return messages.get(id);
    }

    public Message addMessage(Message message){
        message.setId(messages.size() + 1);
        messages.put(message.getId(),message);
        return message;
    }
    public Message updateMessage(Message message){
        if (message.getId() <= 0) {
            return null;
        }
        messages.put(message.getId(),message);
        return message;
    }
    public Message removeMessage(long id){
          return messages.remove(id);
//        Message m = messages.get(id);
//        Iterator<Map.Entry<Long, Message>> iterator = messages.entrySet().iterator() ;
//        while(iterator.hasNext()){
//            Map.Entry<Long, Message> msg = iterator.next();
//            if (msg.getValue().equals(m))
//            {
//                iterator.remove();
//         }
//        }
    }
}
*/