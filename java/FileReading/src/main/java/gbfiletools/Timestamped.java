package java.gbfiletools;


import org.orekit.time.AbsoluteDate;

public interface Timestamped<T> {
     AbsoluteDate getDate();
     AbsoluteDate getTime();
}
