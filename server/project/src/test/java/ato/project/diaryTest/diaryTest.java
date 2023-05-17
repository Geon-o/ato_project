package ato.project.diaryTest;

import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.service.DiaryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class diaryTest {

    @Autowired
    private DiaryService diaryService;

    @Test
    void register(){
        DiaryRegisterRequest diaryRegisterRequest = new DiaryRegisterRequest(1L, "2022.05.06", "Cloud", "bad_condition.png", "제목", "내용");

        System.out.println(diaryService.registerDiary(diaryRegisterRequest));
    }
}
