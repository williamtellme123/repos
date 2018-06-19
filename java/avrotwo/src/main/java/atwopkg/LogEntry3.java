package atwopkg;


// This is the json file on disk as LogEntry3.avsc
//     {
//        "namespace": "me.jeffli.avrosamples.model",
//        "type": "record",
//        "name": "LogEntry2",
//        "fields": [
//        {"name": "name", "type": "string"},
//        {"name": "resource",  "type": ["string", "null"]},
//        {"name": "ip", "type": ["string", "null"]}
//        ]
//     }


// This is the class definition of LogEntry3
public class LogEntry3 {
    private String name;
    private String resource;
    private String ip;

    public LogEntry3(String name, String resource, String ip) {
        this.name = name;
        this.resource = resource;
        this.ip = ip;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }
}
