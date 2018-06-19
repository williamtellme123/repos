
public class Address {
    private String street;
    private String zip;

    public Address() {
    }

    public Address(String street, String zip) {
        this.street = street;
        this.zip = zip;
    }

    @Override
    public String toString() {
        return "Address{" +
                "street='" + street + '\'' +
                ", zip='" + zip + '\'' +
                '}';
    }
}
