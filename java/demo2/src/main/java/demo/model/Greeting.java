package demo.model;

public class Greeting {


    private Long id;
    private String text;


    public Greeting() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public void setText(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }
}
