package ato.project.diary.service;

import ato.project.diary.controller.request.*;
import ato.project.diary.entity.Diary;
import ato.project.diary.mapping.DiaryMapping;
import ato.project.diary.repository.DiaryRepository;
import ato.project.member.entity.Member;
import ato.project.member.repository.MemberRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class DiaryServiceImpl implements DiaryService{

    @Autowired
    private DiaryRepository diaryRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Override
    public List<DiaryMapping> getDiaryList(DiaryListRequest diaryListRequest) {
        Long userId = diaryListRequest.getMemberId();

        Slice<DiaryMapping> diarySlice = diaryRepository.findByDiary(userId, Pageable.ofSize(diaryListRequest.getDiaryCountSize()));
        List<DiaryMapping> diaryList = diarySlice.getContent();

        return diaryList;
    }

    @Override
    public List<DiaryMapping> getNextDiaryList(DiaryNextListRequest diaryNextListRequest) {

        Slice<DiaryMapping> diaryNextSlice = diaryRepository.findByNextDiary(
                diaryNextListRequest.getMemberId(), diaryNextListRequest.getDiaryNo(), Pageable.ofSize(diaryNextListRequest.getDiaryCountSize()));
        List<DiaryMapping> diaryNextList = diaryNextSlice.getContent();

        return diaryNextList;
    }

    @Override
    public boolean registerDiary(DiaryRegisterRequest diaryRegisterRequest) {
        Diary diary = new Diary();

        Optional<Member> maybeMember = memberRepository.findById(diaryRegisterRequest.getMemberId());

        if (maybeMember.isPresent()){
            Member member = maybeMember.get();

            diary.setTitle(diaryRegisterRequest.getTitle());
            diary.setContent(diaryRegisterRequest.getContent());
            diary.setDate(diaryRegisterRequest.getDate());
            diary.setWeather(diaryRegisterRequest.getWeather());
            diary.setConditionStatus(diaryRegisterRequest.getCondition());
            diary.setMember(member);
            diaryRepository.save(diary);

            return true;

        } else {
            return false;
        }
    }

    @Override
    public void deleteDiary(DiaryCommonRequest diaryCommonRequest) {
        diaryRepository.deleteByDiary(diaryCommonRequest.getDiaryNo(), diaryCommonRequest.getMemberId());
    }

    @Override
    public DiaryMapping readDiary(Long diaryNo) {

        DiaryMapping diaryData = diaryRepository.findByDiaryData(diaryNo);

        return diaryData;
    }

    @Override
    public Boolean diaryModify(DiaryModifyRequest diaryModifyRequest) {
        Optional<Diary> maybeDiary = diaryRepository.findById(diaryModifyRequest.getDiaryNo());

        Diary diary;

        if (maybeDiary.isPresent()) {
            diary = maybeDiary.get();
            diary.setTitle(diaryModifyRequest.getTitle());
            diary.setContent(diaryModifyRequest.getContent());
            diaryRepository.save(diary);
            return true;

        } else {
            log.info("등록되지 않은 일기입니다.");
            return false;
        }
    }
}
