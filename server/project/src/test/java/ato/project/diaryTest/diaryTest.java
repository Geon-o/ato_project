package ato.project.diaryTest;

import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.controller.request.DiaryRequest;
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
    void register(){
        DiaryRegisterRequest diaryRegisterRequest = new DiaryRegisterRequest(1L, "2022.05.06", "Cloud", "bad_condition.png", "제목", "내용");

        System.out.println(diaryService.registerDiary(diaryRegisterRequest));
    }

    @Test
    void list(){
        DiaryRequest diaryRequest = new DiaryRequest(1L, 4);

        List<DiaryMapping> diaryMappings = diaryService.getDiaryList(diaryRequest);

        for (int i = 0; i < diaryMappings.size(); i++) {
            System.out.println(
                    diaryMappings.get(i).getDiaryNo() + " " +
                            diaryMappings.get(i).getTitle()  + " " +
                            diaryMappings.get(i).getContent() + " " +
                            diaryMappings.get(i).getDate() + " " +
                            diaryMappings.get(i).getConditionStatus() + " " +
                            diaryMappings.get(i).getWeather()
                    );
        }
    }
}
