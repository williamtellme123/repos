package mymessenger;

import model.Message;

import java.util.*;


public class App {


    public static void main(String[] args) {
//        Calendar cal = Calendar.getInstance();
//        Date d1 = new Date();
//        System.out.println("d1 = "+ d1);
//        cal.setTime(d1);
//        cal.add(Calendar.DATE, -365); // add 1 years
//        d1 = cal.getTime();
//        System.out.println("d1 = "+ d1);
        Long i = null;
        System.out.println("i = " + i);
        Calendar cal = Calendar.getInstance();
        Date d15 = new Date();
        Date d14 = new Date();
        cal.setTime(d14);
        cal.add(Calendar.DATE, -365); // add 1 years
        d14 = cal.getTime();
        System.out.println("d14 = " + d14);
        System.out.println("d15 = " + d15);


        Map<Long, Message> messages = new HashMap();
        messages.put(1L, new Message(1, "Hokums Pokums", new Date(), "Billy"));
        messages.put(2L, new Message(2, "Frikas Frekus", new Date(), "Ellie"));
        messages.put(3L, new Message(3, "Whos there", new Date(), "Ellie"));
        messages.put(4L, new Message(4, "Plpay croquette", new Date(), "Billy"));
        messages.put(5L, new Message(5, "Anyone Home", new Date(), "Ellie"));

        System.out.println("Before remove ----------------------------");
        Iterator<Map.Entry<Long, Message>> iterator = messages.entrySet().iterator() ;
        while(iterator.hasNext()){
            Map.Entry<Long, Message> msg = iterator.next();
            System.out.println(msg.getKey() +" ------------------::------------------ "+ msg.getValue());
//            if (msg.getKey() == 1) iterator.remove();
            //            You can remove elements while iterating.
            //
        }
        long myid = 1;
        Long LongID = new Long(myid);
        messages.remove(LongID);



//        Iterator<Map.Entry<Long, Message>> iterator2 = messages.entrySet().iterator() ;
//        while(iterator.hasNext()){
//            Map.Entry<Long, Message> msg = iterator2.next();
//            System.out.println(msg.getKey() +" :: "+ msg.getValue());
////            if (msg.getKey() == 1) iterator.remove();
//            //            You can remove elements while iterating.
//            //
//        }
        System.out.println("After remove ----------------------------");

        Iterator<Map.Entry<Long, Message>> iterator2 = messages.entrySet().iterator() ;
        while(iterator2.hasNext()){
            Map.Entry<Long, Message> msg = iterator2.next();
            System.out.println(msg.getKey() +" :: "+ msg.getValue());
        }


//        messages.remove(1);
        System.out.println("messages.size()" + messages.size());

    }
}
