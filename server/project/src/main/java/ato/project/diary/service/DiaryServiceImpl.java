package ato.project.diary.service;

import ato.project.diary.controller.request.DiaryRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.entity.Diary;
import ato.project.diary.repository.DiaryRepository;
import ato.project.member.entity.Member;
import ato.project.member.repository.MemberRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
    public List<Diary> getDiaryList(DiaryRequest diaryRequest) {
        Long userId = diaryRequest.getUserId();

//        Slice<Diary> diarySlice = diaryRepository.findByDiary(userId, Pageable.ofSize(diaryRequest.getDiaryCount()));
//        List<Diary> diaryList = diarySlice.getContent();

        return null;
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
            diary.setMember(member);
            diaryRepository.save(diary);

            return true;

        } else {
            return false;
        }
    }
}
