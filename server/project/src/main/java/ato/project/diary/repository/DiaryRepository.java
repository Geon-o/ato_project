package ato.project.diary.repository;

import ato.project.diary.entity.Diary;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {

//    @Query("select d from Diary d join d.member m" +
//            "where m.userId = :userId" +
//            "order by d.")
//    Slice<Diary> findByDiary(@Param("userId")Long userId, Pageable pageable);
}
