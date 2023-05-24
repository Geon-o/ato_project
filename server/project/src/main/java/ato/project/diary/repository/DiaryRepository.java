package ato.project.diary.repository;

import ato.project.diary.entity.Diary;
import ato.project.diary.mapping.DiaryMapping;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {

    @Query("select d.diaryNo as diaryNo, d.title as title, d.content as content, d.conditionStatus as conditionStatus," +
            "d.weather as weather, d.date as date from Diary d join d.member m where m.memberId = :memberId " +
            "order by d.diaryNo desc")
    Slice<DiaryMapping> findByDiary(@Param("memberId")Long memberId, Pageable pageable);

    @Query("select d.diaryNo as diaryNo, d.title as title, d.content as content, d.conditionStatus as conditionStatus, " +
            "d.weather as weather, d.date as date from Diary d where d.member.memberId = :memberId and d.diaryNo < :diaryNo " +
            "order by d.diaryNo desc")
    Slice<DiaryMapping> findByNextDiary(@Param("memberId") Long memberId, @Param("diaryNo") Long diaryNo, Pageable pageable);

    @Modifying
    @Transactional
    @Query("delete from Diary d where d.diaryNo = :diaryNo and  d.member.memberId = :memberId")
    void deleteByDiary(@Param("diaryNo") Long diaryNo, @Param("memberId") Long memberId);

    @Query("select d.diaryNo as diaryNo, d.title as title, d.content as content, d.conditionStatus as conditionStatus," +
            "d.weather as weather, d.date as date from Diary d where d.diaryNo = :diaryNo")
    DiaryMapping findByDiaryData(@Param("diaryNo") Long diaryNo);
}
