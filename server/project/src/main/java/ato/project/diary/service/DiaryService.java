package ato.project.diary.service;

import ato.project.diary.controller.request.DiaryRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.entity.Diary;

import java.util.List;

public interface DiaryService {

    public List<Diary> getDiaryList(DiaryRequest diaryRequest);

    public boolean registerDiary(DiaryRegisterRequest diaryRegisterRequest);
}
