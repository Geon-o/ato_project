package ato.project.diary.service;

import ato.project.diary.controller.request.DiaryDeleteRequest;
import ato.project.diary.controller.request.DiaryListRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.mapping.DiaryMapping;

import java.util.List;

public interface DiaryService {

    public List<DiaryMapping> getDiaryList(DiaryListRequest diaryListRequest);

    public boolean registerDiary(DiaryRegisterRequest diaryRegisterRequest);

    public void deleteDiary(DiaryDeleteRequest diaryDeleteRequest);
}
