package ato.project.diaryTest;

import ato.project.diary.controller.request.*;
import ato.project.diary.mapping.DiaryMapping;
import ato.project.diary.service.DiaryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class diaryTest {

    @Autowired
    private DiaryService diaryService;

    @Test
    void register() {
        DiaryRegisterRequest diaryRegisterRequest = new DiaryRegisterRequest(1L, "2022.05.06", "Cloud", "bad_condition.png", "제목", "내용");

        System.out.println(diaryService.registerDiary(diaryRegisterRequest));
    }

    @Test
    void list() {
        DiaryListRequest diaryListRequest = new DiaryListRequest(2L, 4);

        List<DiaryMapping> diaryMappings = diaryService.getDiaryList(diaryListRequest);

        for (int i = 0; i < diaryMappings.size(); i++) {
            System.out.println(
                    diaryMappings.get(i).getDiaryNo() + " " +
                            diaryMappings.get(i).getTitle() + " " +
                            diaryMappings.get(i).getContent() + " " +
                            diaryMappings.get(i).getDate() + " " +
                            diaryMappings.get(i).getConditionStatus() + " " +
                            diaryMappings.get(i).getWeather()
            );
        }
    }

    @Test
    void nextList() {
        DiaryNextListRequest diaryNextListRequest = new DiaryNextListRequest(2L, 30L, 5);

        List<DiaryMapping> diaryNextList = diaryService.getNextDiaryList(diaryNextListRequest);

        for (int i = 0; i < diaryNextList.size(); i++) {
            System.out.println(
                    diaryNextList.get(i).getDiaryNo() + " " +
                            diaryNextList.get(i).getTitle() + " " +
                            diaryNextList.get(i).getContent() + " " +
                            diaryNextList.get(i).getDate() + " " +
                            diaryNextList.get(i).getConditionStatus() + " " +
                            diaryNextList.get(i).getWeather()
            );

        }
    }

    @Test
    void delete() {
        DiaryCommonRequest diaryCommonRequest = new DiaryCommonRequest(1L, 1L);

        diaryService.deleteDiary(diaryCommonRequest);
    }

    @Test
    void read() {
        Long diaryNo = 7L;
        DiaryMapping data = diaryService.readDiary(diaryNo);
        System.out.println("몇번째 다이어리: "+data.getDiaryNo());
        System.out.println("날짜: "+data.getDate());
        System.out.println("날씨: "+data.getWeather());
        System.out.println("컨디션: "+data.getConditionStatus());
        System.out.println("제목: "+data.getTitle());
        System.out.println("내용: "+data.getContent());
    }

    @Test
    void modify() {
        DiaryModifyRequest diaryModifyRequest = new DiaryModifyRequest(24L, "제목변경", "내용변경");
        diaryService.diaryModify(diaryModifyRequest);
    }
}
