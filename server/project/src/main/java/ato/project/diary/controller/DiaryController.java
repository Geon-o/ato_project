package ato.project.diary.controller;

import ato.project.diary.controller.request.DiaryRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
import ato.project.diary.entity.Diary;
import ato.project.diary.mapping.DiaryMapping;
import ato.project.diary.service.DiaryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/diary")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class DiaryController {

    @Autowired
    private DiaryService diaryService;

    @PostMapping("/list")
    public List<DiaryMapping> diaryList(@RequestBody DiaryRequest diaryRequest){
        log.info("diaryList()" + diaryRequest);

        return diaryService.getDiaryList(diaryRequest);
    }

    @PostMapping("register")
    public Boolean registerDiary(@RequestBody DiaryRegisterRequest diaryRegisterRequest){
        log.info("registerDiary()" + diaryRegisterRequest);

        return diaryService.registerDiary(diaryRegisterRequest);
    }
}
