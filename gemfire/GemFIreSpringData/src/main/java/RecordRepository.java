package src.main.java;

import org.springframework.data.gemfire.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;

@Repository
public interface RecordRepository extends CrudRepository<RecordBean, Integer> {

    RecordBean findByRecordId(String recordId);

    @Query("SELECT * FROM /record")
    Collection<RecordBean> myFindAll();

}