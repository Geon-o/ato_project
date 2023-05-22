package ato.project.diary.controller.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DiaryListRequest {

    private Long memberId;
    private int diaryCountSize;
}
