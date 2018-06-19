public class Animal {

    private String name;

    // Instead of using an interface in a traditional way
    // we use an instance variable that is a subclass
    // of the Flys interface
    public Flys flyingType;

    // Animal doesn't care what flyingType does, it just
    // knows the behavior is available to its subclasses

    // This is known as Composition : Instead of inheriting
    // an ability through inheritance the class is composed
    // with Objects with the right ability

    // Composition allows you to change the capabilities of
    // objects at run time!


    // Animal pushes off the responsibility for flying to flyingType
    public String tryToFly(){
        return flyingType.fly();
    }

    // If you want to be able to change the flyingType dynamically
    // add the following method
    public void setFlyingAbility(Flys newFlyType){
        flyingType = newFlyType;
    }
}