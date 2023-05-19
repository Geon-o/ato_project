package ato.project.diary.repository;

import ato.project.diary.entity.Diary;
import ato.project.diary.mapping.DiaryMapping;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {

    @Query("select d.diaryNo as diaryNo, d.title as title, d.content as content, d.conditionStatus as conditionStatus," +
            "d.weather as weather, d.date as date from Diary d join d.member m where m.memberId = :memberId " +
            "order by d.diaryNo desc")
    Slice<DiaryMapping> findByDiary(@Param("memberId")Long memberId, Pageable pageable);
}
