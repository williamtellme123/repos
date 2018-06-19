package beans;

import javax.ws.rs.QueryParam;


public class MessageFilterBean {
    //    --------------------------------------------------------------------------
    //    KNOWN AS CONTROLLER METHODS THAT CAN USE BEANPARAM
    //    create a separate bean with all annotations
    //    then in your resource class you just say beanparam & accept that bean
    //    --------------------------------------------------------------------------
    //
    //    See    MessageResource
    //           Original param get method commented out and replaced with BeanParam
    //
    @QueryParam("year")
    private int year;

    @QueryParam("start")
    private  int start;

    @QueryParam("size")
    private  int size;

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
