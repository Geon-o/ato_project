package ato.project.diary.service;

import ato.project.diary.controller.request.*;
import ato.project.diary.mapping.DiaryMapping;

import java.util.List;

public interface DiaryService {

    public List<DiaryMapping> getDiaryList(DiaryListRequest diaryListRequest);

    public List<DiaryMapping> getNextDiaryList(DiaryNextListRequest diaryNextListRequest);

    public boolean registerDiary(DiaryRegisterRequest diaryRegisterRequest);

    public void deleteDiary(DiaryCommonRequest diaryCommonRequest);

    public DiaryMapping readDiary(Long diaryNo);

    public Boolean diaryModify(DiaryModifyRequest diaryModifyRequest);
}
