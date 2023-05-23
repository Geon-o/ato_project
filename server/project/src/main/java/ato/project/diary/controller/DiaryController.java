package ato.project.diary.controller;

import ato.project.diary.controller.request.DiaryCommonRequest;
import ato.project.diary.controller.request.DiaryListRequest;
import ato.project.diary.controller.request.DiaryModifyRequest;
import ato.project.diary.controller.request.DiaryRegisterRequest;
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
    public List<DiaryMapping> diaryList(@RequestBody DiaryListRequest diaryListRequest){
        log.info("diaryList()" + diaryListRequest);

        return diaryService.getDiaryList(diaryListRequest);
    }

    @PostMapping("/register")
    public Boolean registerDiary(@RequestBody DiaryRegisterRequest diaryRegisterRequest){
        log.info("registerDiary()" + diaryRegisterRequest);

        return diaryService.registerDiary(diaryRegisterRequest);
    }

    @DeleteMapping("/delete")
    public void delete(@RequestBody DiaryCommonRequest diaryCommonRequest){
        log.info("delete()" + diaryCommonRequest.getDiaryNo());

        diaryService.deleteDiary(diaryCommonRequest);
    }

    @GetMapping("/read/{diaryNo}")
    public DiaryMapping readDiary(@PathVariable("diaryNo") Long diaryNo){
        log.info("readDiary()" + diaryNo);

        return diaryService.readDiary(diaryNo);
    }

    @PutMapping("/modify")
    public Boolean modify(@RequestBody DiaryModifyRequest diaryModifyRequest){
        log.info("modify()" + diaryModifyRequest.getDiaryNo());

        return diaryService.diaryModify(diaryModifyRequest);
    }
}
