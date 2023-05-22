package ato.project.diary.service;

import ato.project.diary.controller.request.DiaryDeleteRequest;
import ato.project.diary.controller.request.DiaryRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.entity.Diary;
import ato.project.diary.mapping.DiaryMapping;

import java.util.List;

public interface DiaryService {

    public List<DiaryMapping> getDiaryList(DiaryRequest diaryRequest);

    public boolean registerDiary(DiaryRegisterRequest diaryRegisterRequest);

    public void deleteDiary(DiaryDeleteRequest diaryDeleteRequest);
}
