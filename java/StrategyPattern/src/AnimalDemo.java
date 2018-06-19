public class AnimalDemo{

    public static void main(String[] args){

        Animal sparky = new Dog();

        System.out.println("Dog: " + sparky.tryToFly());

        // This allows dynamic changes for flyingType
        sparky.setFlyingAbility(new ItFlys());
        System.out.println("Dog: " + sparky.tryToFly());


    }

}



























// http://www.newthinktank.com/2012/08/strategy-design-pattern-tutorial/