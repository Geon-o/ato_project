package ato.project.diary.service;

import ato.project.diary.controller.request.DiaryCommonRequest;
import ato.project.diary.controller.request.DiaryListRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
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
}
