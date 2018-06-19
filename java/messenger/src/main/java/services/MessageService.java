package services;

import database.DatabaseClass;
import model.Message;

import java.util.*;


public class MessageService {

    private Map<Long,Message> messages = DatabaseClass.getMessages();

    public MessageService() {
        Calendar cal = Calendar.getInstance();
        Date d15 = new Date();
        Date d14 = new Date();
        cal.setTime(d14);
        cal.add(Calendar.DATE, -365); // add 1 years
        d14 = cal.getTime();
        System.out.println("d14 = " + d14);
        System.out.println("d15 = "+ d15);
        messages.put(1L, new Message(1, "Hokums Pokums", d14, "Billy"));
        messages.put(2L, new Message(2, "Frikas Frekus", d15, "Ellie"));
        messages.put(3L, new Message(3, "Whos there", d14, "Ellie"));
        messages.put(4L, new Message(4, "Tennis Anyone", d15, "Billy"));
        messages.put(5L, new Message(5, "Anyone Home", new Date(), "Ellie"));
    }

    public List<Message> getAllMessages(){
        return new ArrayList<Message>(messages.values());
    }


    public List<Message> getAllMessagesForYear(int year){
        List<Message> messagesForYear = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        for (Message message : messages.values())
        {
            cal.setTime(message.getCreated());
            if (cal.get(Calendar.YEAR)==year)
            {
                messagesForYear.add(message);
            }
        }
        return messagesForYear;
    }

    public List<Message> getAllMessagesPaginated(int start, int size){
        List<Message> list = new ArrayList<Message>(messages.values());
        if (start + size > list.size()) return new ArrayList<Message>();
        return list.subList(start, start+size);
    }


    public Message getMessage(long id){
        return messages.get(id);
    }

    public Message addMessage(Message message){
        message.setId(messages.size() + 1);
        messages.put(message.getId(), message);
        return message;
    }
    public Message updateMessage(Message message){
        if (message.getId() <= 0) {
            return null;
        }
        messages.put(message.getId(), message);
        return message;
    }
    public Message removeMessage(long id){
        Long LongID = new Long(id);
        return messages.remove(LongID);
    }
}
