package ato.project.diary.controller.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DiaryRegisterRequest {

    private Long memberId;
    private String date;
    private String weather;
    private String condition;
    private String title;
    private String content;

}
